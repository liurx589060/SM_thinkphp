<?php

/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

namespace Sample_Mjmz\Controller;
use Sample_Mjmz\Controller\BaseController;
use JMessage\JMessage;
use JMessage\IM\User;
use JMessage\IM\ChatRoom;
use Sample_Mjmz\Custom\Jchart\JMChartRoomHandler;
use Sample_Mjmz\Custom\Joptions\JchartRoomOptions;
use Sample_Mjmz\Utils\SqlManager;
use Sample_Mjmz\Utils\Common;
use JPush;
use Sample_Mjmz\Utils\ToolUtil;

const CACHE_WAIT = 'waitChartRoom';
const CACHE_STARTED = 'startedChartRoom';
const PRE_KEY = 'chartRoom_';

class JMessageController extends BaseController {
    private $JMClient;
    private $JPushClient;
    private $JMRoom;
    private $JMUser;

    private $_waitChartRoomArray;  //未满员，等待的聊天室
    private $_startedChartRoomArray; //满员，开始了的聊天室

    public function __construct() {
        parent::__construct();
        $this->JMClient = new JMessage(Common::JM_appKey, Common::JM_masterSecret);
        $this->JPushClient = new JPush(Common::JM_appKey, Common::JM_masterSecret);
        $this->JMRoom = new ChatRoom($this->JMClient);
        $this->JMUser = new User($this->JMClient);
        
        $this->_waitChartRoomArray = S(CACHE_WAIT);
        $this->_startedChartRoomArray = S(CACHE_STARTED);
        
        if(!$this->_waitChartRoomArray) {
            $this->_waitChartRoomArray = array();
        }
        if(!$this->_startedChartRoomArray) {
            $this->_startedChartRoomArray = array();
        }
    }

    public function index() {
        $this->returnData($this->convertReturnJsonSucessed('welcome to JMessage'));
    }
    
    private function _addWaitChartRoom(array $handler) {
        if(!isset($this->_waitChartRoomArray)) {
            $this->_waitChartRoomArray = array();
        }
        $this->_waitChartRoomArray[PRE_KEY.$handler['roomId']] = $handler;
        //缓存数组
        S(CACHE_WAIT, $this->_waitChartRoomArray);
        return TRUE;
    }
    
    private function _removeWaitChartRoom(array $handler) {
        $this->_waitChartRoomArray = $this->_removeElementFromArray($handler, $this->_waitChartRoomArray);
        //缓存数组
        S(CACHE_WAIT, $this->_waitChartRoomArray);
        return TRUE;
    }
    
    private function _addStartedChartRoom(array $handler) {
        if(!isset($this->_startedChartRoomArray)) {
            $this->_startedChartRoomArray = array();
        }
        $this->_startedChartRoomArray[PRE_KEY.$handler['roomId']] = $handler;
        //缓存数组
        S(CACHE_STARTED, $this->_startedChartRoomArray);
        return TRUE;
    }
    
    private function _removeStartedChartRoom(array $handler) {
        $this->_startedChartRoomArray = $this->_removeElementFromArray($handler, $this->_startedChartRoomArray);
        //缓存数组
        S(CACHE_STARTED, $this->_startedChartRoomArray);
        return TRUE;
    }
    
    private function _removeElementFromArray(array $handler,array $array) {
        if(!isset($array)) {
            return array();
        }
        if(!array_key_exists(PRE_KEY.$handler['roomId'], $array)){  
            echo 'array not contain the handler';
            return $array;  
        }  
        $keys = array_keys($array);  
        $index = array_search(PRE_KEY.$handler['roomId'], $keys);  
        if($index !== FALSE){  
            array_splice($array, $index, 1);
        }
        return $array;
    }
    
    private function _returnChatRoomData(array $handler) {
        $this->returnData($this->convertReturnJsonSucessed(
                array('roomId'=>$handler['roomId'],
                    'limitLevel'=>$handler['handler']->_limitLevel,
                    'limitLady'=>$handler['handler']->_limitLadyCount,
                    'limitMan'=>$handler['handler']->_limitMan,
                    'limitAngel'=>$handler['handler']->_limitAngel,
                    'gender'=>$handler['gender'],
                    'pushAddress'=>$handler['pushAddress'],
                    'playAddress'=>$handler['playAddress'],
                    'describe'=>$handler['describe'],
                    'creater'=>$handler['creater'],
                    'public'=>$handler['public'],
                    'members'=>$handler['handler']->getUsersArray(),
                    'onLookers'=>$handler['handler']->getOnLookerArray())));
    }


    /**********************************************************************************************************/
    
    /**
     * 获取所有房间
     * http://localhost/thinkphp/Sample_Mjmz/JMessage/getNowChatRoomList?pulic=1  //0:非公开  1：公开  不填则全部
     */
    public function getNowChatRoomList() {
        $public = -1;
        if(isset($_GET['public'])) {
            $public = $_GET['public'];
        }
        $allRoomArray = $this->_waitChartRoomArray + $this->_startedChartRoomArray;
        $resultArray = array();
        foreach ($allRoomArray as $value) {
            $isAdd = false;
            if($public == -1) {
                $isAdd = TRUE;
            }else if($value['public'] == $public){
                $isAdd = TRUE;
            }
            
            if(!$isAdd) {
                continue;
            }
            
            $info['roomId'] = $value['roomId'];
            $info['limitLevel'] = $value['limitLevel'];
            $info['describe'] = $value['describe'];
            $info['limitLadyCount'] = $value['handler']->_limitLadyCount;
            $info['limitMan'] = $value['handler']->_limitMan;
            $info['limitAngel'] = $value['handler']->_limitAngel; 
            $info['public'] = $value['public'];
            $info['gender'] = $value['gender'];
            foreach ($value['handler']->getUsersArray() as $user) {
                if($user['userInfo']['roleType'] == JMChartRoomHandler::ROLRTYPE_ANGEL) {
                    $info['creater'] = $user['userInfo']['userName'];
                }
            }
            
            if($isAdd) {
                $resultArray[] = $info;
            }       
        }
        
        $this->returnData($this->convertReturnJsonSucessed($resultArray));
;    }
    
    private function _checkUserInfoParams($userInfo) {
        if($userInfo['userName'] === NULL || $userInfo['gender'] === NULL || $userInfo['level'] === NULL
            || is_null($userInfo['appoint_time'])) {
            $this->returnData($this->convertReturnJsonError(JMessageController::ERROR_LACK_PARAMS,
                "lack userName or gender or level,appointTime"));
        }
    }

        /**
     * http://localhost/thinkphp/Sample_Mjmz/JMessage/destroyAllChartRoom
     * 删除所有聊天室
     */
    public function destroyAllChartRoom() {
        S(CACHE_WAIT,null);
        S(CACHE_STARTED,null);
    }

    /***********************************************************************************************/
    /**
     * 检测房间是否过期并删除JM Room
     */
    private function _subCheckExpiryChatRoom() {
        $result = SqlManager::subCheckExpiryChatRoom();
        foreach ($result as $info) {
            //删除JM room
            $this->_deleteJMChat($info);
        }
    }

    /**
     * http://localhost/thinkphp/Sample_Mjmz/JMessage/createChatRoom?userName=wsy30201&appointTime=2019-04-16 21:29&public=1&limitLady=10
     * 预约房间
     */
    public function appointChatRoom() {
        $userInfo['user_name'] = $_GET['userName'];
        $userInfo['gender'] = $_GET['gender'];
        $userInfo['limit_level'] = $_GET['limitLevel'];
        $userInfo['level'] = $_GET['level'];
        $userInfo['title'] = $_GET['title'];
        $userInfo['describe'] = $_GET['describe'];
        $userInfo['roomId'] = '';
        $userInfo['push_address'] = $_GET['pushAddress'];
        $userInfo['play_address'] = $_GET['playAddress'];
        $userInfo['public'] =(int)$_GET['public'];
        $userInfo['appoint_time'] = $_GET['appointTime'];
        $userInfo['limit_lady'] = $_GET['limitLady'];
        $userInfo['limit_man'] = $_GET['limitMan'];
        if(is_null($userInfo['user_name']) || is_null($userInfo['push_address'])
            || is_null($userInfo['play_address']) || is_null($userInfo['appoint_time']) || is_null($userInfo['limit_lady'])) {
            $this->returnData($this->convertReturnJsonError(Common::ERROR_LACK_PARAMS ,
                'lack userName,appointTime,public,limitLady,pushAddress,playAddress'));
            return ;
        }

        $this->_checkUserExist($userInfo);
        $this->_subCheckExpiryChatRoom();
        //检测是否有已经预约的或者开始的房间
        $sqlStr = sprintf("SELECT * FROM xq_chat WHERE user_name='%s' AND `work`<>2", $userInfo['user_name']);
        $sqlResult = M()->query($sqlStr);
        if(!empty($sqlResult)) {
            //有已经预约的房间，或者进行中的,则直接返回
            $this->returnData($this->convertReturnJsonError(Common::ERROR_ALREADY_APPOINT_CHATROOM ,
                'you already have appointed room'));
            return ;
        }
        //创建JMMessage 房间
        $roomId = $this->_createJMChat($userInfo);
        //发送JPush消息
        if($userInfo['public'] == 1) {
            //公开的
            $pusher = $this->JPushClient->push();
            $pusher->setPlatform('all');
            $pusher->addAllAudience();
            $extraArray['type'] = Common::JPUSH_TYPE_CHAT_ROOM_CREATE;
            $extraArray['data'] = [];
            $pusher->setMessage(json_encode($extraArray),'create','json',null);
            try {
                $pusher->send();
            } catch (JPushException $e) {
                // try something else here
                print $e;
            }
        }

        $userInfo['room_id'] = $roomId;
        //房间创建成功，存入数据库
        $sqlResult = SqlManager::appointChatRoom($userInfo);
        if(!$sqlResult) goto error;
        $this->returnData($this->convertReturnJsonSucessed($userInfo));

        error:
            $this->returnData($this->convertReturnJsonError());
    }

    /**
     * 检测房间是否存在
     * @param $sqlData
     * @return bool|void
     */
    private function _checkChatRoomExist($sqlData) {
        $result = M(SqlManager::TABLE_CHAT)->where("room_id='%s'",$sqlData['room_id'])->find();
        if(!$result) {
            $this->returnData($this->convertReturnJsonError(Common::ERROR_NOT_FIND_CHATROOM ,
                'cannot find the room'));
            return ;
        }
        return true;
    }

    /**
     * 检测用户是否存在
     * @param $sqlData
     * @return mixed|void
     */
    private function _checkUserExist($sqlData) {
        $result = M(SqlManager::TABLE_USER)->where("user_name='%s'",$sqlData['user_name'])->find();
        if(!$result) {
            $this->returnData($this->convertReturnJsonError(Common::ERROR_USER_NOT_EXIST ,
                'user is not exist'));
            return ;
        }
        return $result;
    }

    /**
     * http://localhost/thinkphp/Sample_Mjmz/JMessage/deleteChatRoom?roomId=123456
     * 删除房间
     */
    public function deleteChatRoom() {
        $userInfo['user_name'] = $_GET['userName'];
        $userInfo['room_id'] = $_GET['roomId'];
        $userInfo['status'] = $_GET['status'];

        if(is_null($userInfo['user_name']) || is_null($userInfo['room_id']) || is_null($userInfo['status'])) {
            $this->returnData($this->convertReturnJsonError(Common::ERROR_LACK_PARAMS ,
                'lack userName，roomId,status'));
            return ;
        }
        $this->_checkUserExist($userInfo);
        //检测房间是否存在
        $this->_checkChatRoomExist($userInfo);
        $result = M(SqlManager::TABLE_CHAT)->where("room_id='%s'",$userInfo['room_id'])->find();
        //处理数据库
        //删除聊天室
        $this->_deleteJMChat($result);
        $pusher = $this->JPushClient->push();
        $pusher->setPlatform('all');
        $pusher->addAllAudience();
        $extraArray['type'] = Common::JPUSH_TYPE_CHAT_ROOM_DELETE;
        $extraArray['data'] = [];
        $pusher->setMessage(json_encode($extraArray),'delete','json',null);
        try {
            $pusher->send();
        } catch (JPushException $e) {
            // try something else here
            print $e;
        }

        $sqlResult = SqlManager::deleteChatRoom($userInfo);
        if(!$sqlResult) {
            $this->returnData($this->convertReturnJsonError());
            return;
        }
        $this->returnData($this->convertReturnJsonSucessed($result));
    }

    /**
     * http://localhost/thinkphp/Sample_Mjmz/JMessage/joinChatRoom
     * 加入房间，两种情况，1：匹配模式   2：指定房间模式（其中包括参与者和围观者身份）
     */
    public function joinChatRoom() {
        $userInfo['user_name'] = $_GET['userName'];
        $userInfo['gender'] = $_GET['gender'];
        $userInfo['level'] = $_GET['level'];
        $userInfo['room_id'] = $_GET['roomId'];
        $userInfo['handleType'] = $_GET['handleType'];   // 1匹配模式  2：指定房间模式
        $userInfo['room_role_type'] = $_GET['roomRoleType'];
        if(is_null($userInfo['user_name']) || is_null($userInfo['gender']) || is_null($userInfo['handleType'])
            || is_null($userInfo['room_role_type'])) {
            $this->returnData($this->convertReturnJsonError(Common::ERROR_LACK_PARAMS ,
                'lack userName，gender,handleType,roomRoleType'));
            return ;
        }

        if($userInfo['handleType'] == 1 && $userInfo['room_role_type'] == 2) {
            //匹配模式并且是围观者
            $this->returnData($this->convertReturnJsonError(Common::ERROR_ROLETYPE_NOT_MATCH ,
                'roleType is not match'));
            return ;
        }

        if($userInfo['handleType'] == 2 && is_null($userInfo['room_id'])) {
            //指定模式
            $this->returnData($this->convertReturnJsonError(Common::ERROR_LACK_PARAMS ,
                'lack room_id'));
            return ;
        }

        $this->_checkUserExist($userInfo);
        $this->_subCheckExpiryChatRoom();
        //检测是否有已经加入的房间
        $sqlStr = sprintf("SELECT * FROM xq_chat_user WHERE user_name='%s' and  `work`<>2",
            $userInfo['user_name']);
        $sqlResult = M()->query($sqlStr);
        if(!empty($sqlResult)) {
            //有已经预约的房间，或者进行中的,则直接返回
            $this->returnData($this->convertReturnJsonError(Common::ERROR_ALREADY_JOIN_CHATROOM ,
                'you have already join room'));
            return ;
        }

        //检测房间是否存在
        if($userInfo['handleType'] == 2) {
            //指定模式
            $this->_checkChatRoomExist($userInfo);
        }

        $sqlResult = SqlManager::joinChatRoom($userInfo);
        if(!$sqlResult) goto error;

        //加入到JM chat
        $userInfo['room_id'] = $sqlResult['room_id'];
        //去客户端加入
        //数据库操作成功了
        $this->_joinJMChat($userInfo);
        $this->returnData($this->convertReturnJsonSucessed($sqlResult));
        //$this->returnData($this->convertReturnJsonSucessed());

        error:
            $this->returnData($this->convertReturnJsonError());
    }


    /**
     * http://localhost/thinkphp/Sample_Mjmz/JMessage/exitChatRoom?userName=wys30201&roomId=123456&status=0
     * 退出房间
     */
    public function exitChatRoom() {
        $userInfo['user_name'] = $_GET['userName'];
        $userInfo['room_id'] = $_GET['roomId'];
        $userInfo['status'] = $_GET['status'];
        $userInfo['inner_id'] = $_GET['innerId'];
        $userInfo['joinType'] = $_GET['joinType'];  // 1:参与者     2：排队

        if(is_null($userInfo['user_name']) || is_null($userInfo['room_id']) || is_null($userInfo['status'])
            || is_null($userInfo['inner_id']) || is_null($userInfo['joinType'])) {
            $this->returnData($this->convertReturnJsonError(Common::ERROR_LACK_PARAMS ,
                'lack userName，roomId,status,joinType'));
            return ;
        }
        $this->_checkUserExist($userInfo);
        //检测房间是否存在
        $this->_checkChatRoomExist($userInfo);
        $result = M(SqlManager::TABLE_CHAT)->where("room_id='%s'",$userInfo['room_id'])->find();
        //处理数据库
        $sqlResult = SqlManager::exitChatRoom($userInfo,false);
        if($sqlResult === false) {
            $this->returnData($this->convertReturnJsonError());
            return;
        }
        $this->returnData($this->convertReturnJsonSucessed($result));
    }

    /**
     * http://localhost/thinkphp/Sample_Mjmz/JMessage/startChatRoom?roomId=123456
     * 房间开始
     */
    public function startChatRoom() {
        $userInfo['room_id'] = $_GET['roomId'];
        if(is_null($userInfo['room_id'])) {
            $this->returnData($this->convertReturnJsonError(Common::ERROR_LACK_PARAMS ,
                'lack roomId'));
            return ;
        }
        //检测房间是否存在
        $this->_checkChatRoomExist($userInfo);
        //处理数据库
        $sqlResult = SqlManager::startChatRoom($userInfo);
        if(!$sqlResult) {
            $this->returnData($this->convertReturnJsonError());
            return;
        }
        $this->returnData($this->convertReturnJsonSucessed($sqlResult));
    }


    /**
     * http://localhost/thinkphp/Sample_Mjmz/JMessage/enterChatRoom?roomId=123456
     * 进入房间
     */
    public function enterChatRoom() {
        $userInfo['room_id'] = $_GET['roomId'];
        $userInfo['user_name'] = $_GET['userName'];
        if(is_null($userInfo['room_id']) || is_null($userInfo['user_name'])) {
            $this->returnData($this->convertReturnJsonError(Common::ERROR_LACK_PARAMS ,
                'lack roomId,userName'));
            return ;
        }

        //检测房间是否存在
        $this->_checkChatRoomExist($userInfo);
        $roomInfo = M(SqlManager::TABLE_CHAT)->where("room_id='%s'",$userInfo['room_id'])->find();
        if($roomInfo['work'] == 2) {
            //则房间已经解散
            $this->returnData($this->convertReturnJsonError(Common::ERROR_ALREADY_DELETE_CHATROOM,
                "the chat room is deleted"));
        }
        $result = M(SqlManager::TABLE_CHAT_USER)->where("room_id='%s' and user_name='%s' and end_time is null"
            ,$userInfo['room_id'],$userInfo['user_name'])
            ->setField("in_room",1);
        if(!$result) goto error;
        $sqlResult = SqlManager::getChatRoomMember($userInfo,1);
        $roomInfo['members'] = $sqlResult;
        $roomInfo['inner_id'] = '';
        if($roomInfo['work'] == 1) {
            //判断xq_chat_room_user是否有记录
            $result = M(SqlManager::TABLE_CHAT_ROOM_USER)->where("room_id='%s' and user_name='%s' and inner_id='%s'",
                $userInfo['room_id'],$userInfo['user_name'],$roomInfo['inner_id'])
                ->select();
            if(empty($result)) {
                //进行中，不存在记录,则添加到xq_chat_room_user的记录中(主要是围观者中途进入)
                $roomChat = M(SqlManager::TABLE_CHAT_ROOM)->where("room_id='%s' and end_time is null")->find();
                $info = M(SqlManager::TABLE_CHAT_USER)->where("room_id='%s' and user_name='%s' and work<>2"
                    ,$userInfo['room_id'],$userInfo['user_name']);
                $info['status'] = 0;
                $info['start_time'] = ToolUtil::getCurrentTime();
                $insertData['inner_id'] = $roomChat['inner_id'];
                $roomInfo['inner_id'] = $roomChat['inner_id'];
                M(SqlManager::TABLE_CHAT_ROOM_USER)->add($info);
            }
        }
        $this->returnData($this->convertReturnJsonSucessed($roomInfo));

        //goto,返回错误
        error:
            $this->returnData($this->convertReturnJsonError());
    }

    /**
     * http://localhost/thinkphp/Sample_Mjmz/JMessage/leaveChatRoom?roomId=123456
     * 进入房间
     */
    public function leaveChatRoom() {
        $userInfo['room_id'] = $_GET['roomId'];
        $userInfo['user_name'] = $_GET['userName'];
        if(is_null($userInfo['room_id']) || is_null($userInfo['user_name'])) {
            $this->returnData($this->convertReturnJsonError(Common::ERROR_LACK_PARAMS ,
                'lack roomId,userName'));
            return ;
        }

        //检测房间是否存在
        $this->_checkChatRoomExist($userInfo);
        //标记为不在房间内
        $result = M(SqlManager::TABLE_CHAT_USER)->where("room_id='%s' and user_name='%s' and work<>2"
            ,$userInfo['room_id'],$userInfo['user_name'])
            ->setField("in_room",0);
        if($result == false) {
            $this->returnData($this->convertReturnJsonError());
        }
        $this->returnData($this->convertReturnJsonSucessed());
    }

    /**
     * http://localhost/thinkphp/Sample_Mjmz/JMessage/getChatRoomByUser?userName=wys30201
     * 根据用户名获取房间
     */
    public function getChatRoomByUser() {
        $userInfo['user_name'] = $_GET['userName'];
        if(is_null($userInfo['user_name'])) {
            $this->returnData($this->convertReturnJsonError(Common::ERROR_LACK_PARAMS ,
                'lack userName'));
            return ;
        }

        $sqlResult = SqlManager::getChatRoomByUser($userInfo);
        $this->returnData($this->convertReturnJsonSucessed($sqlResult));
    }


    /**
     * http://localhost/thinkphp/Sample_Mjmz/JMessage/getChatRoomMember?roomId=123456&roomRoleType=1
     * 获取房间的成员
     */
    public function getChatRoomMember() {
        $userInfo['room_id'] = $_GET['roomId'];
        $userInfo['room_role_type'] = $_GET['roomRoleType'];
        if(is_null($userInfo['room_id']) || is_null($userInfo['room_role_type'])) {
            $this->returnData($this->convertReturnJsonError(Common::ERROR_LACK_PARAMS ,
                'lack roomId,roomRoleType'));
            return ;
        }
        //检测房间是否存在
        $this->_checkChatRoomExist($userInfo);
        //处理数据库
        $sqlResult = SqlManager::getChatRoomMember($userInfo,$userInfo['room_role_type']);
        $this->returnData($this->convertReturnJsonSucessed($sqlResult));
    }

    /**
     * http://localhost/thinkphp/Sample_Mjmz/JMessage/getChatRoomList?public=1&work=1&status=0
     * 获取房间列表
     */
    public function getChatRoomList() {
        $this->_subCheckExpiryChatRoom();
        $info['public'] = $_GET['public'];  //0：私密  1;公开   -1：所有 (可多选，比如public=0,1)
        $info['work'] = $_GET['work'];  //0：初始化   1：进行中    2：已结束  -1:所有  (可多选，work=0,1,2)
        $info['status'] = $_GET['status']; //0：未匹配成功  1：匹配成功  -1：取消  -2:所有  (可多选，status=0,1,-1)
        if(is_null($info['public'])) {
            $info['public'] = -1;
        }
        if(is_null($info['work'])) {
            $info['work'] = -1;
        }
        if(is_null($info['status'])) {
            $info['status'] = -2;
        }
        $sqlResult = SqlManager::getChatRoomList($info);
        $this->returnData($this->convertReturnJsonSucessed($sqlResult));
    }

    /**
     * 上报房间结果
     */
    public function commitChatRoomResult() {
        $userInfo['room_id'] = $_GET['roomId'];
        $userInfo['status'] = $_GET['status'];     //0:失败    1：成功
        $userInfo['inner_id'] = $_GET['innerId'];
        $userInfo['man_user'] = $_GET['manUser'];
        $userInfo['lady_user'] = $_GET['ladyUser'];
        if(is_null($userInfo['room_id']) || is_null($userInfo['status']) || is_null($userInfo['inner_id'])) {
            $this->returnData($this->convertReturnJsonError(Common::ERROR_LACK_PARAMS ,
                'lack roomId,status,innerId'));
            return ;
        }

        if($userInfo['status'] == 1 && !is_null($userInfo['man_user']) && !is_null($userInfo['lady_user'])) {//成功
            $this->returnData($this->convertReturnJsonError(Common::ERROR_LACK_PARAMS ,
                'lack manUser,ladyUser'));
            return ;
        }
        //检测房间是否存在
        $this->_checkChatRoomExist($userInfo);
        $sqlResult = SqlManager::commitChatRoomResult($userInfo);
        if(!$sqlResult) {
            $this->returnData($this->convertReturnJsonError());
            return;
        }
        $this->returnData($this->convertReturnJsonSucessed());
    }

    /**
     * 删除 JM Chat Room
     * @param $info
     * @return false
     */
    private function _deleteJMChat($info) {
        $result = $this->JMRoom->delete($info['room_id']);
        if($result['body']['error'] !== NULL) {
            if(!$result['body']['error']['code'] == 899081) {
                //房间已被删除
                $this->returnData($this->convertReturnJsonError(Common::ERROR_DELETE_CHARTEOOM
                    , $result['body']['error']['code'].'--->>'.$result['body']['error']['message']));
                return;
            }
        } else {
            //创建成功
            return true;
        }
    }

    /**
     * 创建JM Chat Room
     * @param $info
     */
    private function _createJMChat($info) {
        $result = $this->JMRoom->create('xq_chartRoom', $info['user_name'], array(), 'xq_chartRoom');
        if($result['body']['error'] !== NULL) {
            $this->returnData($this->convertReturnJsonError(Common::ERROR_CREATE_CHARTEOOM
                , $result['body']['error']['code'].'--->>'.$result['body']['error']['message']));
            return;
        } else {
            //创建成功
            $roomId = $result['body']['chatroom_id'];
            return $roomId;
        }
    }

    /**
     * 加入 JM Chat Room
     * @param $info
     * @return false
     */
    private function _joinJMChat($info) {
        //先退出其他的chat Room
        $result = $this->_exitJMChat(true,$info['room_id'],$info['user_name']);
        $result = $this->JMRoom->addMembers($info['room_id'], array($info['user_name']));
        if($result['body']['error'] !== NULL) {
            $this->returnData($this->convertReturnJsonError(Common::ERROR_JOIN_CHARTEOOM
                , $info['body']['error']['code'].'--->>'.$info['body']['error']['message']));
            return;
        } else {
            //创建成功
            return true;
        }
    }

    /**
     * 退出 JM Chat Room
     * @param $info
     * @return false
     */
    private function _exitJMChat(bool $isAll,$roomId,$userName) {
        $result = false;
        if($isAll) {
            //退出所有
            $result = $this->JMUser->chatrooms($userName);
            if($result['body']['error'] === NULL) {
                //有加入过的聊天室
                foreach ($result['body'] as $value) {
                    if($value['owner_username'] == $userName) {
                        $this->JMRoom->delete($value['id']);
                    }else {
                        $this->JMRoom->removeMembers($value['id'], array($userName));
                    }
                }
            }
        }else {
            $result = $this->JMRoom->removeMembers($roomId, array($userName));
        }
        return $result;
    }


    /**
     * http://localhost/thinkphp/Sample_Mjmz/JMessage/getJMChatRoomByUser?userName=wys30201
     */
    public function getJMChatRoomByUser() {
        $userName = $_GET['userName'];
        $result = $this->JMUser->chatrooms($userName);
        $this->returnData($this->convertReturnJsonSucessed($result));
    }

    /**
     * http://localhost/thinkphp/Sample_Mjmz/JMessage/deleteJMChatRoomByUser?userName=wys30201
     */
    public function deleteJMChatRoomByUser() {
        $userName = $_GET['userName'];
        $result = $this->JMUser->chatrooms($userName);
        foreach ($result['body'] as $item) {
            $aa['room_id'] = $item['id'];
            $this->JMRoom->delete($aa['room_id']);
        }
        $this->returnData($this->convertReturnJsonSucessed());
    }



    /**
     * http://localhost/thinkphp/Sample_Mjmz/JMessage/createChartRoom?userName=sy30201&gender=女&level=12
     * 创建聊天室
     */
    public function createChartRoom() {
        $userInfo = array();
        $userInfo['userName'] = $_GET['userName'];
        $userInfo['gender'] = $_GET['gender'];
        $userInfo['level'] = $_GET['level'];
        $userInfo['roomId'] = '';
        $userInfo['pushAddress'] = $_GET['pushAddress'];
        $userInfo['playAddress'] = $_GET['playAddress'];
        $userInfo['public'] =(int)$_GET['public'];
        $userInfo['appoint_time'] = $_GET['appointTime'];
        $userInfo['limit_lady'] = $_GET['limitLady'];
        $userInfo['limit_man'] = $_GET['limitMan'];
        $this->_checkUserInfoParams($userInfo);

        $userInfo = $userInfo + SqlManager::getUserInfoBySql($userInfo);

        $option = new JchartRoomOptions();
        $option->jmClient = $this->JMClient;
        if($_GET['limitLevel'] !== NULL) {
            $option->limitLevel = $_GET['limitLevel'];
        }
        if($_GET['limitLady'] !== NULL) {
            $option->limitLady = $_GET['limitLady'];
        }
        if($_GET['limitMan'] !== NULL) {
            $option->limitMan = $_GET['limitMan'];
        }
        if($_GET['limitAngel'] !== NULL) {
            $option->limitAngel = $_GET['limitAngel'];
        }
        $chartHandler = new JMChartRoomHandler($option);
        $usersArray = $chartHandler->createChartRoom($this,$userInfo);
        $array = array();
        $array['gender'] = $chartHandler->getRestGender();
        $array['limitLevel'] = $chartHandler->getLimitLevel();
        $array['roomId'] = $chartHandler->getChartRoomId();
        $array['handler'] = $chartHandler;
        $array['pushAddress'] = $userInfo['pushAddress'];
        $array['playAddress'] = $userInfo['playAddress'];
        $array['public'] = $userInfo['public'];
        $array['describe'] = $_GET['describe'];
        $array['appoint_time'] = $userInfo['appoint_time'];
        $array['creater'] = $userInfo['userName'];
        //加入创建的handler
        $array['gender'] = $chartHandler->getRestGender();
        $this->_addWaitChartRoom($array);
        S(CACHE_WAIT, $this->_waitChartRoomArray);
        if($array['public'] == 1) {
            //公开的
            $pusher = $this->JPushClient->push();
            $pusher->setPlatform('all');
            $pusher->addTag(Common::JPUSH_TAG_CHAT);
            $extraArray['type'] = Common::JPUSH_TYPE_CHAT_ROOM_CREATE;
            $extraArray['data'] = [];
            $pusher->setMessage(json_encode($extraArray),'create','json',null);
            try {
                $pusher->send();
            } catch (JPushException $e) {
                // try something else here
                print $e;
            }
        }

        //存入数据库
        $bean['room_id'] = $array['roomId'];
        $bean['create_time'] = ToolUtil::getCurrentTime();
        $bean['creater'] = $userInfo['userName'];
        $bean['describe'] = $array['describe'];
        $bean['public'] = $array['public'];
        $bean['appoint_time'] = $array['appoint_time'];
        $bean['status'] = 0;
        SqlManager::updateChatRoom($bean, 1);

        //存入数据库
        $bean['room_id'] = $array['roomId'];
        $bean['user_name'] = $userInfo['userName'];
        $bean['status'] = 0;
        $bean['enter_time'] = ToolUtil::getCurrentTime();
        $bean['room_role_type'] = 1;
        SqlManager::updateRoomRecord($bean, 1);

        $this->_returnChatRoomData($array);
    }

    public function deleteChartRoom() {
        if(is_null($_GET['userName']) || is_null($_GET['roomId']) || is_null($_GET['status'])) {
            $this->returnData($this->convertReturnJsonError(JMessageController::ERROR_LACK_PARAMS,'lack userName,roomId,status'));
        }

        //存入数据库
        $result = SqlManager::getChatRoomById($_GET['roomId']);
        $result['delete_time'] = ToolUtil::getCurrentTime();
        $result['status'] = $_GET['status'];
        SqlManager::updateChatRoom($result, 2);

        //存入数据库
        $result = SqlManager::getRoomRecordById($_GET['userName'],$_GET['roomId']);
        $result['exit_time'] = ToolUtil::getCurrentTime();
        $result['status'] = 0;
        SqlManager::updateRoomRecord($result, 2);

        $this->deleteRoom($_GET['roomId']);
    }

        /**
     * http://localhost/thinkphp/Sample_Mjmz/JMessage/deleteChartRoom?roomId=1005
     * 删除聊天室
     */
    public function deleteRoom($roomId) {
        $mergeArray = $this->_waitChartRoomArray + $this->_startedChartRoomArray;
        $handlerWrapper = $mergeArray[PRE_KEY.$roomId];
        if($handlerWrapper === NULL) {
            $this->returnData($this->convertReturnJsonError(JMessageController::ERROR_NO_MATCH, 'can not match chartRoom'
                    . '--'.$roomId));
            return;
        }
        $handler = $handlerWrapper['handler'];
        $result = $handler->deleteChartRoom($this,$roomId);
        if($result) {
            $handlerWrapper = $this->_waitChartRoomArray[PRE_KEY.$roomId];
            if($handlerWrapper === NULL) {
                $handlerWrapper = $this->_startedChartRoomArray[PRE_KEY.$roomId];
                $this->_removeStartedChartRoom($handlerWrapper);
            } else {
                $this->_removeWaitChartRoom($handlerWrapper);
            }
            
            if($handlerWrapper['public'] == 1) {
                $pusher = $this->JPushClient->push();
                $pusher->setPlatform('all');
                $pusher->addTag(Common::JPUSH_TAG_CHAT);
                $extraArray['type'] = Common::JPUSH_TYPE_CHAT_ROOM_DELETE;
                $extraArray['info']['creater'] = $handlerWrapper['userName'];
                $extraArray['info']['public'] = $handlerWrapper['public'];
                $extraArray['info']['roomId'] = $handlerWrapper['roomId'];
                $pusher->setMessage(json_encode($extraArray),'delete','json',null);
                try {
                    $pusher->send();
                } catch (JPushException $e) {
                    // try something else here
                    print $e;
                }
            } 
            $this->returnData($this->convertReturnJsonSucessed());
        }
    }

    /**
     * http://localhost/thinkphp/Sample_Mjmz/JMessage/matchChartRoom?gender=男
     * 匹配聊天室
     */
    private function _matchChartRoom() {
        $gender = $_GET['gender']=='男'?JMChartRoomHandler::MAN: JMChartRoomHandler::LADY;
        $level = $_GET['level'];
        $roleType = $_GET['roleType'];
        foreach ($this->_waitChartRoomArray as $handler){
            if($roleType == JMChartRoomHandler::ROLRTYPE_ANGEL) {
                if(strpos($handler['gender'], JMChartRoomHandler::ANGEL)) {
                    return $handler['roomId'];
                }
            } else {
                $result = strpos($handler['gender'], $gender);
                if($result !== FALSE) {//匹配到了
                    return $handler['roomId'];
                }
            }
        }
        $this->returnData($this->convertReturnJsonError(JMessageController::ERROR_NO_MATCH, 'no match chartRoom'));
    }

    /**
     * http://localhost/thinkphp/Sample_Mjmz/JMessage/joinChartRoom?userName=wys30201&gender=100&level=5
     * 加入聊天室
     */
//    public function joinChartRoom() {
//        if(!isset($_GET['userName'])||!isset($_GET['gender'])||!isset($_GET['level'])||!isset($_GET['roleType'])
//                || !isset($_GET['roomRoleType'])) {
//            $this->returnData($this->convertReturnJsonError(JMessageController::ERROR_LACK_PARAMS,
//                    'lack userName,gender,level,roleType,roomRoleType'));
//            return;
//        }
//
//        if($_GET['roomRoleType'] == JMessageController::CHAT_ROOM_ROLETYPE_ONLOOKER) {
//            if($_GET['userName'] == NULL) {
//                $this->returnData($this->convertReturnJsonError(JMessageController::ERROR_LACK_PARAMS,
//                    'lack roomId'));
//                return;
//            }
//        }
//
//        if($_GET['roomRoleType'] == JMessageController::CHAT_ROOM_ROLETYPE_PARTICIPANTS) {
//            //参与者
//            $this->_joinChatRoomWithParticipants();
//        }else {
//            $this->_joinChartRoomWithOnLooker();
//        }
//    }
//
//    private function _joinChatRoomWithParticipants() {
//        $roomId = $this->_matchChartRoom();
//        $handler = $this->_waitChartRoomArray[PRE_KEY.$roomId];
//        if($handler === NULL) {
//            $this->returnData($this->convertReturnJsonError(JMessageController::ERROR_NO_MATCH, 'the roomId is wrong'));
//            return;
//        }
//        $userInfo = array();
//        $userInfo['userName'] = $_GET['userName'];
//
//        $userInfo = $userInfo + SqlManager::getUserInfoBySql($userInfo);
//
//        $userInfo['gender'] = $_GET['gender'];
//        $userInfo['level'] = $_GET['level'];
//        $userInfo['roleType'] = $_GET['roleType'];
//        $userInfo['roomId'] = $roomId;
//        $userInfo['roomRoleType'] = $_GET['roomRoleType'];
//        $handler['handler']->joinChartRoom($this,$userInfo);
//        $handler['gender'] = $handler['handler']->getRestGender();
//        if($handler['gender'] == JMChartRoomHandler::FULL) {//满员
//            $this->_removeWaitChartRoom($handler);
//            $this->_addStartedChartRoom($handler);
//        } else {
//            $this->_waitChartRoomArray[PRE_KEY.$roomId] = $handler;
//            //修改了数组，缓存
//            S(CACHE_WAIT, $this->_waitChartRoomArray);
//        }
//
//        //存入数据库
//        $bean['room_id'] = $userInfo['roomId'];
//        $bean['user_name'] = $userInfo['userName'];
//        $bean['status'] = 0;
//        $bean['enter_time'] = ToolUtil::getCurrentTime();
//        $bean['room_role_type'] = $_GET['roomRoleType'];
//        SqlManager::updateRoomRecord($bean, 1);
//
//        $this->_returnChatRoomData($handler);
//    }
    
    /**
     * http://localhost/thinkphp/Sample_Mjmz/JMessage/joinChartRoomWithOnLooker?roomId=1256
     * 围观者加入聊天室
     */
    private function _joinChartRoomWithOnLooker() {    
        $mergeArray = $this->_waitChartRoomArray + $this->_startedChartRoomArray;
        $handlerWrapper = $mergeArray[PRE_KEY.$_GET['roomId']];
        if($handlerWrapper === NULL) {
            $this->returnData($this->convertReturnJsonError(JMessageController::ERROR_NO_MATCH, 'can not match chartRoom'
                    . '--'.$_GET['roomId']));
            return;
        }
        $handler = $handlerWrapper['handler'];
        $userInfo = array();
        $userInfo['userName'] = $_GET['userName'];  
        $userInfo['roomRoleType'] = $_GET['roomRoleType'];
        $userInfo['roomId'] = $_GET['roomId'];
        $userInfo = $userInfo + SqlManager::getUserInfoBySql($userInfo);
        $handler->joinChartRoom($this,$userInfo);       
        if($this->_waitChartRoomArray[PRE_KEY.$_GET['roomId']] != NULL) {
            $this->_waitChartRoomArray[PRE_KEY.$_GET['roomId']] = $handlerWrapper;
            //修改了数组，缓存
            S(CACHE_WAIT, $this->_waitChartRoomArray);
        }else {
            $this->_startedChartRoomArray[PRE_KEY.$_GET['roomId']] = $handlerWrapper;
            //修改了数组，缓存
            S(CACHE_STARTED, $this->_startedChartRoomArray);
        }  
        
        //存入数据库 
        $bean['room_id'] = $userInfo['roomId'];
        $bean['user_name'] = $userInfo['userName'];
        $bean['status'] = 0;
        $bean['enter_time'] = ToolUtil::getCurrentTime();
        $bean['room_role_type'] = $_GET['roomRoleType'];   
        SqlManager::updateRoomRecord($bean, 1);
        
        $this->_returnChatRoomData($handlerWrapper);  
    }
    
     private function _exitChartRoomWithOnLooker() {
        $type = 1;
        $handlerWrapper = $this->_waitChartRoomArray[PRE_KEY.$_GET['roomId']];
        if($handlerWrapper === NULL) {
            $handlerWrapper = $this->_startedChartRoomArray[PRE_KEY.$_GET['roomId']];
            $type = 2;
        }
        if($handlerWrapper === NULL) {
            $this->returnData($this->convertReturnJsonError(JMessageController::ERROR_NO_MATCH, 'can not match chartRoom'
                    . '--'.$_GET['roomId']));
            return;
        }
        $handlerWrapper['handler']->exitChartRoomWithOnLookers($this,$_GET['roomId'],$_GET['userName']);  
        if($type==1) {
            $this->_waitChartRoomArray[PRE_KEY.$_GET['roomId']] = $handlerWrapper;
            S(CACHE_WAIT, $this->_waitChartRoomArray);
        }else if($type == 2) {
            $this->_waitChartRoomArray[PRE_KEY.$_GET['roomId']] = $handlerWrapper;
            S(CACHE_STARTED, $this->_waitChartRoomArray);
        }
        
        //存入数据库
        $result = SqlManager::getRoomRecordById($_GET['userName'],$_GET['roomId']);
        $result['exit_time'] = ToolUtil::getCurrentTime();
        $result['status'] = $_GET['status'];
        SqlManager::updateRoomRecord($result, 2);
        
        $this->_returnChatRoomData($handlerWrapper);  
    }

     /**
     * http://localhost/thinkphp/Sample_Mjmz/JMessage/exitChartRoom?roomId=1256&userName=wys30201
     * 退出聊天室
     */
    public function exitChartRoom() {
        if($_GET['roomId'] === NULL || $_GET['userName']=== NULL || $_GET['roomRoleType']=== NULL
                || $_GET['status']=== NULL) {
            $this->returnData($this->convertReturnJsonError(JMessageController::ERROR_LACK_PARAMS
                    , 'lack roomId or userName,roomRoleType,status'));
            return ;
        }
        
        if($_GET['roomRoleType'] == JMessageController::CHAT_ROOM_ROLETYPE_PARTICIPANTS) {
            //参与者
            $this->_exitChartRoomWithParticipants();
        }else {
            $this->_exitChartRoomWithOnLooker();
        }
    }
    
    private function _exitChartRoomWithParticipants() {
        $type = 1;
        $handlerWrapper = $this->_waitChartRoomArray[PRE_KEY.$_GET['roomId']];
        if($handlerWrapper === NULL) {
            $handlerWrapper = $this->_startedChartRoomArray[PRE_KEY.$_GET['roomId']];
            $type = 2;
        }
        if($handlerWrapper === NULL) {
            $this->returnData($this->convertReturnJsonError(JMessageController::ERROR_NO_MATCH, 'can not match chartRoom'
                    . '--'.$_GET['roomId']));
            return;
        }
        switch ($type) {
            case 1:
                $this->_exitWaitChartRoom($handlerWrapper);
                break;
            case 2:
                $this->_exitStartedChartRoom($handlerWrapper);
                break;
            default:
                break;
        }
    }
    
    private function _exitWaitChartRoom($handlerWrapper) {
        $handler = $handlerWrapper['handler'];
        if(!$handler->exitChartRoomWithParticipants($this,$_GET['roomId'],$_GET['userName'])) {//删除失败
            $this->returnData($this->convertReturnJsonError(JMessageController::ERROR_EXIT_CHARTROOM, 'exit the chartRoom failed'));
            return;
        }
        $handlerWrapper['gender'] = $handler->getRestGender();
        $this->_waitChartRoomArray[PRE_KEY.$_GET['roomId']] = $handlerWrapper;
        if(count($handler->getUsersArray()) <= 0) {
            $this->_removeWaitChartRoom($handlerWrapper);
        }
        S(CACHE_WAIT, $this->_waitChartRoomArray);
        
        $result = SqlManager::getRoomRecordById($_GET['userName'],$_GET['roomId']);
        $result['exit_time'] = ToolUtil::getCurrentTime();
        $result['status'] = $_GET['status'];
        SqlManager::updateRoomRecord($result, 2);
        $this->_returnChatRoomData($handlerWrapper);   
    }
    
    private function _exitStartedChartRoom($handlerWrapper) {
        $handler = $handlerWrapper['handler'];
        if(!$handler->exitChartRoomWithParticipants($this,$_GET['roomId'],$_GET['userName'])) {//删除失败
            $this->returnData($this->convertReturnJsonError(JMessageController::ERROR_EXIT_CHARTROOM, 'exit the chartRoom failed'));
            return;
        }
        $this->_startedChartRoomArray[PRE_KEY.$_GET['roomId']] = $handlerWrapper;
        if(count($handler->getUsersArray()) <= 0) {
            $this->_removeStartedChartRoom($handlerWrapper);
        }
        S(CACHE_STARTED, $this->_startedChartRoomArray);
        
        $result = SqlManager::getRoomRecordById($_GET['userName'],$_GET['roomId']);
        $result['exit_time'] = ToolUtil::getCurrentTime();
        $result['status'] = $_GET['status'];
        SqlManager::updateRoomRecord($result, 2);
        
        $this->_returnChatRoomData($handlerWrapper);   
    }

        /**
     * http://localhost/thinkphp/Sample_Mjmz/JMessage/getChartRoomMemeberList?roomId=1256
     * 获取聊天室成员列表
     * @return type
     */
    public function getChartRoomMemeberList() {
        $mergeArray = $this->_waitChartRoomArray + $this->_startedChartRoomArray;
        $handlerWrapper = $mergeArray[PRE_KEY.$_GET['roomId']];
        if($handlerWrapper === NULL) {
            $this->returnData($this->convertReturnJsonError(Common::ERROR_NO_MATCH, 'can not match chartRoom'
                    . '--'.$_GET['roomId']));
            return;
        }
        $this->_returnChatRoomData($handlerWrapper);    
    }
    
    
       /**
     * http://localhost/thinkphp/Sample_Mjmz/JMessage/getChartMembersByUserName?userName=wys30201
     * 根据userName查询RoomId
     * @return type
     */
    public function getChartMembersByUserName() {
        $userName = $_GET['userName'];
        if(!isset($userName)) {
            $this->returnData($this->convertReturnJsonError(JMessageController::ERROR_LACK_PARAMS
                    , 'userName'));
            return ;
        }
        $mergeArray = $this->_waitChartRoomArray + $this->_startedChartRoomArray;
        foreach ($mergeArray as $handlerWrapper) {
            $handler = $handlerWrapper['handler'];
            $userArray = $handler->getUsersArray();
            foreach ($userArray as $user) {
                if($user['userInfo']['user_name'] === $userName) {
                    $this->_returnChatRoomData($handlerWrapper);
                    return;
                }                
            }
        }
        $this->returnData($this->convertReturnJsonError(JMessageController::ERROR_NO_MATCH
                    , 'can not match chartRoom'. '--'.$userName));
        return ;
    }
    
    /**
     * get
     * http://localhost/thinkphp/Sample_Mjmz/JMessage/changePassword?userName=wys30201&password=aaa1254b4
     * 修改密码
     */
    public function changePassword() {
        if($_GET['userName'] === NULL || $_GET['password']=== NULL ) {
            $this->returnData($this->convertReturnJsonError(JMessageController::ERROR_LACK_PARAMS
                    , 'lack userName or password'));
            return ;
        }
        
        $userInfo['userName'] = $_GET['userName'];
        $userInfo['password'] = $_GET['password'];
        $sqlResult = SqlManager::checkUserExist(SqlManager::TABLE_USER,$userInfo);
        if($sqlResult) {
            $sql = M(SqlManager::TABLE_USER);
            $JMUser = new User($this->JMClient);
            $JMUser->updatePassword($userInfo['userName'], $userInfo['password']);
            $userInfo['modify_time'] = date("Y-m-d G:i:s");
            $data = array('password'=>$userInfo['password'],'modify_time'=>$userInfo['modify_time']);
            $result = $sql->where("user_name='%s'",$userInfo['userName'])->setField($data);
            if($result) {
                $this->returnData($this->convertReturnJsonSucessed('密码修改成功'));
            }else {
                $this->returnData($this->convertReturnJsonError(Common::ERROR_USER_PASSWORD_CHANGE,'change password error'));
            }
        } else {
            $this->returnData($this->convertReturnJsonError(Common::ERROR_USER_NOT_EXIST,'user is not exist'));
        }
    }

    /**
     * http://localhost/thinkphp/Sample_Mjmz/JMessage/getChatRoomListByUser?userName=wys30201
     * 获取用户参与过的房间
     */
    public function getChatRoomListByUser() {
        $user_name = $_GET['userName'];
        if(is_null($user_name)) {
            $this->returnData($this->convertReturnJsonError(Common::ERROR_LACK_PARAMS ,
                'lack userName'));
            return ;
        }

        $sqlData['user_name'] = $user_name;
        $SqlResult = SqlManager::getChatRoomListByUser($sqlData);
        $this->returnData($this->convertReturnJsonSucessed($SqlResult));
    }
}
