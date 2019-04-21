<?php

/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
namespace Sample_Mjmz\Custom\Jchart;
use JMessage\IM\User;
use JMessage\IM\ChatRoom;
use Sample_Mjmz\Custom\Joptions\JchartRoomOptions;
use Sample_Mjmz\Controller\JMessageController;

const PRE_USER_KEY = 'user_';//userArray 的key前缀

class JMChartRoomHandler {
    const MAN = '男';  //男士
    const LADY = '女'; //女生
    const ANGEL = '天使'; //天使
    const FULL = ''; //满员

    private $_JMClient;
    private $_JMUser;
    private $_JMRoom;
    private $_restGender = JMChartRoomHandler::MAN.JMChartRoomHandler::LADY.JMChartRoomHandler::ANGEL; //剩余性别
    private $_countMan = 0;//男生数量
    private $_countAngel = 0;//大使数量
    private $_countLady = 0;//女生数量
    public $_limitLadyCount = 0;//人数总数，默认12个
    public $_limitMan = 0;//男生总量
    public $_limitAngel = 0;//天使总量
    public $_limitLevel = -1;//等级区域，默认-1，-1则表示不做等级的限制 
    private $_chartRoomId = -1;//聊天室的Id
    private $_userArray = array();//加入的用户数组
    private $_onLookerArray = array();//加入的用户数组
    private $_exitIndexArray = array();//退出的索引数组
    private $_mAngelStart = False;   //是否点击开始
    private $_nOnLookerIndex = 0;   //围观者的序号

    public function __construct(JchartRoomOptions $options) {
        $this->_JMClient = $options->jmClient;
        $this->_JMUser = new User($this->_JMClient);
        $this->_limitLadyCount = $options->limitLady;
        $this->_limitAngel = $options->limitAngel;
        $this->_limitMan = $options->limitMan;
        $this->_limitLevel = $options->limitLevel;
        $this->_JMRoom = new ChatRoom($this->_JMClient);
    }
    
    /**
     * 创建聊天室
     * @return boolean
     */
    public function createChartRoom(JMessageController $controller,$userInfo) {
        $this->_clearChartRoom($userInfo['userName']);
        $info = $this->_JMRoom->create('test_chartRoom', $userInfo['userName'], array(), '测试room');
        if($info['body']['error'] !== NULL) {
            $controller->returnData($controller->convertReturnJsonError(JMessageController::ERROR_CREATE_CHARTEOOM
                    , $info['body']['error']['code'].'--->>'.$info['body']['error']['message']));           
        } else {
            $this->_chartRoomId = $info['body']['chatroom_id'];
            $userInfo['roomId'] = $this->_chartRoomId;
            $userInfo['roleType'] = JMChartRoomHandler::ROLRTYPE_ANGEL;
            $this->_userArray[] = array(
                'index'=>$this->_countAngel, 
                'roomRoleType'=> JMessageController::CHAT_ROOM_ROLETYPE_PARTICIPANTS,
                'userInfo'=>$userInfo
                );
            $this->_countAngel++;
            return $this->_userArray;
        }
    }
    
    /**
     * 删除聊天室
     * @param type $roomId
     */
    public function deleteChartRoom(JMessageController $controller,$roomId) {
        $result = $this->_JMRoom->delete($roomId); 
        if($result['body']['error'] !== NULL) {
            $controller->returnData($controller->convertReturnJsonError(JMessageController::ERROR_DELETE_CHARTEOOM
                    , $result['body']['error']['code'].'--->>'.$result['body']['error']['message']));           
        } else {
            return TRUE;
        }
    }
    
    private function _conventIndex($userInfo) {
        $index = -1;
        $roleType = $_GET['roleType'];
        $count = count($this->_exitIndexArray);
        if($count > 0) {//有退出的情况
            for($n=0;$n<$count;$n++) {
                $instance = $this->_exitIndexArray[$n];
                if($roleType == JMChartRoomHandler::ROLRTYPE_ANGEL) {
                    if($instance['userInfo']['roleType'] == JMChartRoomHandler::ROLRTYPE_ANGEL) {
                        $index = $instance['index'];
                        $this->_countAngel++;
                        return $index;
                    }
                } else {
                    if($instance['userInfo']['gender'] == $userInfo['gender']) {
                        $index = $instance['index'];
                        array_splice($this->_exitIndexArray,$n,1);
                        $gender = $userInfo['gender'];
                        if($gender == '男') {
                            $this->_countMan++;
                        } else {
                            $this->_countLady++;         
                        }
                        return $index;
                    }
                }
            }
        }
        
        if($roleType == JMChartRoomHandler::ROLRTYPE_ANGEL) {
            $index = $this->_countAngel;
            $this->_countAngel++;
        } else {
            $gender = $userInfo['gender'];
            if($gender == '男') {
                $index = $this->_countMan;
                $this->_countMan++;
            } else {
                $index = $this->_countLady;
                $this->_countLady++;         
            }
        }
        return $index;
    }
    
    private function _clearChartRoom($userName) {
        if($result['body']['error'] === NULL) {
                //有加入过的聊天室
                foreach ($result['body'] as $value) {
                    if($value['owner_username'] == $userName) {
                        $this->_JMRoom->delete($value['id']);
                    }else {
                        $this->_JMRoom->removeMembers($value['id'], array($userInfo['userName']));
                    }                
                }
        }
    }

    /**
     * 加入聊天室
     */
    public function joinChartRoom(JMessageController $controller,$userInfo,$noJmessage=False) {      
        if(!$noJmessage) {
            $this->_clearChartRoom($userInfo['userName']);
            $result = $this->_JMRoom->addMembers($userInfo['roomId'], array($userInfo['userName']));
            if($result['body']['error'] !== NULL) {
                $controller->returnData($controller->convertReturnJsonError(JMessageController::ERROR_JOIN_CHARTEOOM
                     , $result['body']['error']['code'].'--->>'.$result['body']['error']['message']));          
            } 
        }
        $userInfo['roleType'] = $_GET['roleType'];
        if($userInfo['roomRoleType'] == JMessageController::CHAT_ROOM_ROLETYPE_PARTICIPANTS) {
            //参与者
            $index = $this->_conventIndex($userInfo);
            $this->_userArray[] = array(
                'index'=>$index,
                'roomRoleType'=>$userInfo['roomRoleType'],
                'userInfo'=>$userInfo
            );
        } else if($userInfo['roomRoleType'] == JMessageController::CHAT_ROOM_ROLETYPE_ONLOOKER){
            //围观者
            $this->_onLookerArray[] = array(
                'index'=> $this->_nOnLookerIndex++,
                'roomRoleType'=>$userInfo['roomRoleType'],
                'userInfo'=>$userInfo
            );
        }
       
        return True;
    }
    
    /**
     * 退出聊天室
     */
    public function exitChartRoomWithParticipants(JMessageController $controller,$roomId,$userName) {
        $result = $this->_JMRoom->removeMembers($roomId, array($userName));
        if($result['body']['error'] !== NULL) {
            if($result['body']['error']['message'] == '') {
                $controller->deleteRoom($roomId);
                return;
            }
            $controller->returnData($controller->convertReturnJsonError(JMessageController::ERROR_JOIN_CHARTEOOM
                    , $result['body']['error']['code'].'--->>'.$result['body']['error']['message']));           
        } else {
            for ($i = 0;$i<count($this->_userArray);$i++) {
            $user = $this->_userArray[$i];
            if($user['userInfo']['userName'] == $userName) {//匹配上
                switch ($user['userInfo']['roleType']) {
                    case JMChartRoomHandler::ROLRTYPE_ANGEL:
                        $this->_countAngel--;
                        break;
                    case JMChartRoomHandler::ROLETYPE_GUEST:
                        if($user['userInfo']['gender']== '男') {
                            $this->_countMan--;
                        } else {
                            $this->_countLady--;
                        }
                        break;
                    default:
                        break;
                }
                array_splice($this->_userArray, $i,1); 
//                $this->_exitIndexArray[] = $index;
                $this->_exitIndexArray[] = $user;
                break;
                }
            }
            return TRUE;
        }
    }
    
    public function exitChartRoomWithOnLookers(JMessageController $controller,$roomId,$userName) {
        $result = $this->_JMRoom->removeMembers($roomId, array($userName));
        if($result['body']['error'] !== NULL) {
            if($result['body']['error']['message'] == '') {
                $controller->deleteRoom($roomId);
                return;
            }
            $controller->returnData($controller->convertReturnJsonError(JMessageController::ERROR_JOIN_CHARTEOOM
                    , $result['body']['error']['code'].'--->>'.$result['body']['error']['message']));           
        } else {
            for ($i = 0;$i<count($this->_onLookerArray);$i++) {
                $user = $this->_onLookerArray[$i];
                if($user['userInfo']['userName'] == $userName) {
                    array_splice($this->_onLookerArray, $i,1); 
                }        
            }
            return TRUE;
        }
    }
     
    /**
     * 获取聊天室的成员列表
     */
    public function getChartRoomMemeberList() {
        
    }

     /**
     * 获取剩余的性别
     */
    public function getRestGender() {
        $gender = JMChartRoomHandler::FULL;
        $angelFull = TRUE;
        $ladyFull = TRUE;
        if($this->_countAngel < $this->_limitAngel) {
            $gender .= JMChartRoomHandler::ANGEL; 
            $angelFull = FALSE;
        }
        
        if($this->_countLady < $this->_limitLadyCount) {//女生小于限制
            $gender .= JMChartRoomHandler::LADY;
            $ladyFull = FALSE;
        }
        
        if($angelFull&&$ladyFull&&($this->_countMan < $this->_limitMan)) {//男生小于限制
                $gender .= JMChartRoomHandler::MAN;
        }
        $this->_restGender = $gender;
        return $this->_restGender;
    }
    
    /**
     * 获取剩余人数
     * @return type
     */
    public function getRestCount() {
        $num = $this->_limitCount - $this->_countMan - $this->_countLady;
        if($num <= 0) {
            $this->_restGender = FULL;
        }
        return $num;
    }
    
    /**
     * 获取聊天室房间Id
     * @return type
     */
    public function getChartRoomId() {
        return $this->_chartRoomId;
    }
    
    public function getLimitLevel() {
        return $this->_limitLevel;
    }
    
    public function getUsersArray() {
        return $this->_userArray;
    }
    
    public function getOnLookerArray() {
        return $this->_onLookerArray;
    }
}
