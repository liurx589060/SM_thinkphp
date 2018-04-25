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
    const MAN = 1000;  //男士
    const LADY = 1001; //女生
    const MIX = 1002;  //剩余
    const FULL = 1003; //满员

    private $_JMClient;
    private $_JMUser;
    private $_JMRoom;
    private $_restGender = MIX; //剩余性别
    private $_countMan = 0;//男生数量
    private $_countLady = 0;//女生数量
    private $_limitCount = 0;//人数总数，默认12个
    private $_limitLevel = -1;//等级区域，默认-1，-1则表示不做等级的限制 
    private $_chartRoomId = -1;//聊天室的Id
    private $_userArray = array();//加入的用户数组
    private $_exitIndexArray = array();//退出的索引数组

    public function __construct(JchartRoomOptions $options) {
        $this->_JMClient = $options->jmClient;
        $this->_JMUser = new User($this->_JMClient);
        $this->_limitCount = $options->limitCount;
        $this->_limitLevel = $options->limitLevel;
        $this->_JMRoom = new ChatRoom($this->_JMClient);
    }
    
    /**
     * 创建聊天室
     * @return boolean
     */
    public function createChartRoom(JMessageController $controller) {
        $info = $this->_JMRoom->create('test_chartRoom', 'wys30201', array(), '测试room');
        if($info['body']['error'] !== NULL) {
            $controller->returnData($controller->convertReturnJsonError(JMessageController::ERROR_CREATE_CHARTEOOM
                    , $info['body']['error']['code'].'--->>'.$info['body']['error']['message']));           
        } else {
            $this->_chartRoomId = $info['body']['chatroom_id'];
            return TRUE;
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
        if(count($this->_exitIndexArray) > 0) {
            $index = $this->_exitIndexArray[0];
            array_splice($this->_exitIndexArray,0,1);
            $gender = $userInfo['gender'];
            if($gender == '男') {
                $this->_countMan++;
            } else {
                $this->_countLady++;         
            }
        } else {
            $gender = $userInfo['gender'];
            if($gender == '男') {
                $index = 2*$this->_countMan;
                $this->_countMan++;
            } else {
                $index = 2*$this->_countLady + 1;
                $this->_countLady++;         
            }
        }
        return $index;
    }

    /**
     * 加入聊天室
     */
    public function joinChartRoom(JMessageController $controller,$userInfo,$noJmessage=False) {
        $index = $this->_conventIndex($userInfo);
        if(!$noJmessage) {
            $result = $this->_JMRoom->addMembers($userInfo['roomId'], array($userInfo['userName']));
            if($result['body']['error'] !== NULL) {
                $controller->returnData($controller->convertReturnJsonError(JMessageController::ERROR_JOIN_CHARTEOOM
                     , $result['body']['error']['code'].'--->>'.$result['body']['error']['message']));          
            } else {
                $this->_userArray[] = array(
                'index'=>$index,
                'userInfo'=>$userInfo
                );
                return $this->_userArray;
            }
        } else {
            $this->_userArray[] = array(
                'index'=>$index,
                'userInfo'=>$userInfo
            );
            return $this->_userArray;
        }
    }
    
    /**
     * 退出聊天室
     */
    public function exitChartRoom(JMessageController $controller,$roomId,$userName,$index) {
        $result = $this->_JMRoom->removeMembers($roomId, array($userName));
        if($result['body']['error'] !== NULL) {
            $controller->returnData($controller->convertReturnJsonError(JMessageController::ERROR_JOIN_CHARTEOOM
                    , $result['body']['error']['code'].'--->>'.$result['body']['error']['message']));           
        } else {
            for ($i = 0;$i<count($this->_userArray);$i++) {
            $user = $this->_userArray[$i];
            if($user['index'] == $index) {//匹配上
                if($user['userInfo']['gender']== '男') {
                    $this->_countMan--;
                } else {
                    $this->_countLady--;
                }
                array_splice($this->_userArray, $i,1); 
                $this->_exitIndexArray[] = $index;
                break;
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
        $limit = $this->_limitCount/2;
        if($this->_countMan < $limit) {//男生少于平均
            if($this->_countLady < $limit) {//女生也少于平均
                $this->_restGender = JMChartRoomHandler::MIX;
            } else {
                $this->_restGender = JMChartRoomHandler::MAN;
            }
        } else {//男生人数大于等于平均
            if($this->_countLady < $limit) {//女生少于平均
                $this->_restGender = JMChartRoomHandler::LADY;
            } else {
                $this->_restGender = JMChartRoomHandler::FULL;
            }
        }
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
}
