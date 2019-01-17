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
use Sample_Mjmz\Custom\Jchart\JMChartRoomHandler;
use Sample_Mjmz\Custom\Joptions\JchartRoomOptions;
use Sample_Mjmz\Utils\SqlManager;
use Sample_Mjmz\Utils\Common;
use JPush;

const CACHE_WAIT = 'waitChartRoom';
const CACHE_STARTED = 'startedChartRoom';
const PRE_KEY = 'chartRoom_';
const JPUSH_TAG_CHAT = 'tag_chat_room';
const JPUSH_TYPE_CHAT_ROOM_CREATE = 1;
const JPUSH_TYPE_CHAT_ROOM_DELETE = 2;

class JMessageController extends BaseController {
    const ERROR_NO_MATCH = 7000;//未匹配上
    const ERROR_EXIT_CHARTROOM = 7001;//退出失败
    const ERROR_LACK_PARAMS = 7002;//缺少参数
    const ERROR_DELETE_CHARTEOOM = 7003;//删除聊天室失败
    const ERROR_CREATE_CHARTEOOM = 7004;//创建聊天室失败
    const ERROR_JOIN_CHARTEOOM = 7005;//创建聊天室失败
    
    const CHAT_ROOM_ROLETYPE_PARTICIPANTS = 1; //参与者
    const CHAT_ROOM_ROLETYPE_ONLOOKER = 2; //围观者


    private $JMClient;
    private $JPushClient;
    private $appKey = '2f3cff28d0bcc572927bf624';
    private $masterSecret = 'cd7be344156c9afc0d218bad'; 
    
    private $_waitChartRoomArray;  //未满员，等待的聊天室
    private $_startedChartRoomArray; //满员，开始了的聊天室

    public function __construct() {
        parent::__construct();
        $this->JMClient = new JMessage($this->appKey, $this->masterSecret);
        $this->JPushClient = new JPush($this->appKey, $this->masterSecret);
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
     * http://localhost/thinkphp/Sample_Mjmz/JMessage/getArrays?pulic=0  //0:非公开  1：公开  不填则全部
     */
    public function getArrays() {
//        $this->returnData($this->convertReturnJsonSucessed(array(
//            'wait'=>$this->_waitChartRoomArray,
//            'started'=> $this->_startedChartRoomArray)
//        ));
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
        if($userInfo['userName'] === NULL || $userInfo['gender'] === NULL || $userInfo['level'] === NULL) {
            $this->returnData($this->convertReturnJsonError(JMessageController::ERROR_LACK_PARAMS, "lack userName or gender or level"));
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
        $array['creater'] = $userInfo['userName'];
        //加入创建的handler
        $array['gender'] = $chartHandler->getRestGender();
        $this->_addWaitChartRoom($array); 
        S(CACHE_WAIT, $this->_waitChartRoomArray);
        if($array['public'] == 1) {
            $pusher = $this->JPushClient->push();
            $pusher->setPlatform('all');
            $pusher->addTag(JPUSH_TAG_CHAT);
            $extraArray['type'] = JPUSH_TYPE_CHAT_ROOM_CREATE;
            $extraArray['info']['creater'] = $array['creater'];
            $extraArray['info']['public'] = $array['public'];
            $extraArray['info']['roomId'] = $array['roomId'];
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
        $bean['create_time'] = time();
        $bean['creater'] = $userInfo['userName'];
        $bean['describe'] = $array['describe'];
        $bean['status'] = 0;   
        SqlManager::updateChatRoom($bean, 1);
        
        //存入数据库 
        $bean['room_id'] = $array['roomId'];
        $bean['user_name'] = $userInfo['userName'];
        $bean['status'] = 0;
        $bean['enter_time'] = time();
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
        $result['delete_time'] = time();
        $result['status'] = $_GET['status'];
        SqlManager::updateChatRoom($result, 2);
        
        //存入数据库
        $result = SqlManager::getRoomRecordById($_GET['userName'],$_GET['roomId']);
        $result['exit_time'] = time();
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
                $pusher->addTag(JPUSH_TAG_CHAT);
                $extraArray['type'] = JPUSH_TYPE_CHAT_ROOM_DELETE;
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
    public function joinChartRoom() {
        if(!isset($_GET['userName'])||!isset($_GET['gender'])||!isset($_GET['level'])||!isset($_GET['roleType'])
                || !isset($_GET['roomRoleType'])) {
            $this->returnData($this->convertReturnJsonError(JMessageController::ERROR_LACK_PARAMS,
                    'lack userName,gender,level,roleType,roomRoleType'));
            return;
        }
        
        if($_GET['roomRoleType'] == JMessageController::CHAT_ROOM_ROLETYPE_ONLOOKER) {
            if($_GET['userName'] == NULL) {
                $this->returnData($this->convertReturnJsonError(JMessageController::ERROR_LACK_PARAMS,
                    'lack roomId'));
                return;
            }
        }
        
        if($_GET['roomRoleType'] == JMessageController::CHAT_ROOM_ROLETYPE_PARTICIPANTS) {
            //参与者
            $this->_joinChatRoomWithParticipants();
        }else {
            $this->_joinChartRoomWithOnLooker();
        }
    }
    
    private function _joinChatRoomWithParticipants() {
        $roomId = $this->_matchChartRoom();
        $handler = $this->_waitChartRoomArray[PRE_KEY.$roomId];
        if($handler === NULL) {
            $this->returnData($this->convertReturnJsonError(JMessageController::ERROR_NO_MATCH, 'the roomId is wrong'));
            return;
        }
        $userInfo = array();
        $userInfo['userName'] = $_GET['userName'];
        
        $userInfo = $userInfo + SqlManager::getUserInfoBySql($userInfo);
        
        $userInfo['gender'] = $_GET['gender'];
        $userInfo['level'] = $_GET['level'];
        $userInfo['roleType'] = $_GET['roleType'];
        $userInfo['roomId'] = $roomId;
        $userInfo['roomRoleType'] = $_GET['roomRoleType'];
        $handler['handler']->joinChartRoom($this,$userInfo);
        $handler['gender'] = $handler['handler']->getRestGender();
        if($handler['gender'] == JMChartRoomHandler::FULL) {//满员
            $this->_removeWaitChartRoom($handler);
            $this->_addStartedChartRoom($handler);
        } else {
            $this->_waitChartRoomArray[PRE_KEY.$roomId] = $handler;
            //修改了数组，缓存
            S(CACHE_WAIT, $this->_waitChartRoomArray);
        }
        
        //存入数据库 
        $bean['room_id'] = $userInfo['roomId'];
        $bean['user_name'] = $userInfo['userName'];
        $bean['status'] = 0;
        $bean['enter_time'] = time();
        $bean['room_role_type'] = $_GET['roomRoleType'];   
        SqlManager::updateRoomRecord($bean, 1);
        
        $this->_returnChatRoomData($handler);
    }
    
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
        $bean['enter_time'] = time();
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
        $result['exit_time'] = time();
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
        $result['exit_time'] = time();
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
        $result['exit_time'] = time();
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
            $this->returnData($this->convertReturnJsonError(JMessageController::ERROR_NO_MATCH, 'can not match chartRoom'
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
     * http://localhost/thinkphp/Sample_Mjmz/user/changePassword?userName=wys30201&password=aaa1254b4
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
}
