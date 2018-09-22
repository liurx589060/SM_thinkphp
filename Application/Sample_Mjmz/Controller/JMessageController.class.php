<?php

/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

namespace Sample_Mjmz\Controller;
use Sample_Mjmz\Controller\BaseController;
use JMessage\JMessage;
use Sample_Mjmz\Custom\Jchart\JMChartRoomHandler;
use Sample_Mjmz\Custom\Joptions\JchartRoomOptions;
use Sample_Mjmz\Utils\SqlManager;

const CACHE_WAIT = 'waitChartRoom';
const CACHE_STARTED = 'startedChartRoom';
const PRE_KEY = 'chartRoom_';

class JMessageController extends BaseController {
    const ERROR_NO_MATCH = 7000;//未匹配上
    const ERROR_EXIT_CHARTROOM = 7001;//退出失败
    const ERROR_LACK_PARAMS = 7002;//缺少参数
    const ERROR_DELETE_CHARTEOOM = 7003;//删除聊天室失败
    const ERROR_CREATE_CHARTEOOM = 7004;//创建聊天室失败
    const ERROR_JOIN_CHARTEOOM = 7005;//创建聊天室失败


    private $JMClient;
    private $appKey = 'd4f1d053cfdba36011487fea';
    private $masterSecret = '78eddf9e1636ecc3397f0fa9'; 
    
    private $_waitChartRoomArray;  //未满员，等待的聊天室
    private $_startedChartRoomArray; //满员，开始了的聊天室

    public function __construct() {
        parent::__construct();
        $this->JMClient = new JMessage($this->appKey, $this->masterSecret);
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
    
    public function getArrays() {
        $this->returnData($this->convertReturnJsonSucessed(array(
            'wait'=>$this->_waitChartRoomArray,
            'started'=> $this->_startedChartRoomArray)
        ));
    }
    
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
        //加入创建的handler
        $array['gender'] = $chartHandler->getRestGender();
        $this->_addWaitChartRoom($array); 
        S(CACHE_WAIT, $this->_waitChartRoomArray);
        $this->returnData($this->convertReturnJsonSucessed(
                array('roomId'=>$array['roomId'],
                    'limitLevel'=>$chartHandler->_limitLevel,
                    'limitLady'=>$chartHandler->_limitLadyCount,
                    'limitMan'=>$chartHandler->_limitMan,
                    'limitAngel'=>$chartHandler->_limitAngel,
                    'pushAddress'=>$array['pushAddress'],
                    'playAddress'=>$array['playAddress'],
                    'members'=>$usersArray)));
    }
    
    public function deleteChartRoom() {
        if(!$_GET['roomId']) {
            $this->returnData($this->convertReturnJsonError(JMessageController::ERROR_LACK_PARAMS,'lack roomId'));
        }
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
        if(!isset($_GET['userName'])||!isset($_GET['gender'])||!isset($_GET['level'])||!isset($_GET['roleType'])) {
            $this->returnData($this->convertReturnJsonError(JMessageController::ERROR_LACK_PARAMS,
                    'lack userName,gender,level,roleType'));
            return;
        }
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
        $result = $handler['handler']->joinChartRoom($this,$userInfo);
        $handler['gender'] = $handler['handler']->getRestGender();
        if($handler['gender'] == JMChartRoomHandler::FULL) {//满员
            $this->_removeWaitChartRoom($handler);
            $this->_addStartedChartRoom($handler);
        } else {
            $this->_waitChartRoomArray[PRE_KEY.$roomId] = $handler;
            //修改了数组，缓存
            S(CACHE_WAIT, $this->_waitChartRoomArray);
        }
        $this->returnData($this->convertReturnJsonSucessed(
                array('roomId'=>$roomId,
                    'limitLevel'=>$handler['handler']->_limitLevel,
                    'limitLady'=>$handler['handler']->_limitLadyCount,
                    'limitMan'=>$handler['handler']->_limitMan,
                    'limitAngel'=>$handler['handler']->_limitAngel,
                    'members'=>$result)));
    }
    
    /**
     * http://localhost/thinkphp/Sample_Mjmz/JMessage/exitChartRoom?roomId=1256&index=3
     * 退出聊天室
     */
    public function exitChartRoom() {
        $type = 1;
        if($_GET['roomId'] === NULL || $_GET['userName']=== NULL) {
            $this->returnData($this->convertReturnJsonError(JMessageController::ERROR_LACK_PARAMS
                    , 'lack roomId or userName'));
            return ;
        }
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
        if(!$handler->exitChartRoom($this,$_GET['roomId'],$_GET['userName'])) {//删除失败
            $this->returnData($this->convertReturnJsonError(JMessageController::ERROR_EXIT_CHARTROOM, 'exit the chartRoom failed'));
            return;
        }
        $handlerWrapper['gender'] = $handler->getRestGender();
        $this->_waitChartRoomArray[PRE_KEY.$_GET['roomId']] = $handlerWrapper;
        if(count($handler->getUsersArray()) <= 0) {
            $this->_removeWaitChartRoom($handlerWrapper);
        }
        S(CACHE_WAIT, $this->_waitChartRoomArray);
        $this->returnData($this->convertReturnJsonSucessed(
                array('roomId'=>$handlerWrapper['roomId'],
                    'limitLevel'=>$handler->_limitLevel,
                    'limitLady'=>$handler->_limitLadyCount,
                    'limitMan'=>$handler->_limitMan,
                    'limitAngel'=>$handler->_limitAngel,
                    'members'=>$handler->getUsersArray())));
    }
    
    private function _exitStartedChartRoom($handlerWrapper) {
        $handler = $handlerWrapper['handler'];
        if(!$handler->exitChartRoom($this,$_GET['roomId'],$_GET['userName'])) {//删除失败
            $this->returnData($this->convertReturnJsonError(JMessageController::ERROR_EXIT_CHARTROOM, 'exit the chartRoom failed'));
            return;
        }
        $this->_startedChartRoomArray[PRE_KEY.$_GET['roomId']] = $handlerWrapper;
        if(count($handler->getUsersArray()) <= 0) {
            $this->_removeStartedChartRoom($handlerWrapper);
        }
        S(CACHE_STARTED, $this->_startedChartRoomArray);
        $this->returnData($this->convertReturnJsonSucessed(
                array('roomId'=>$handlerWrapper['roomId'],
                    'limitLevel'=>$handler->_limitLevel,
                    'limitLady'=>$handler->_limitLadyCount,
                    'limitMan'=>$handler->_limitMan,
                    'limitAngel'=>$handler->_limitAngel,
                    'members'=>$handler->getUsersArray())));
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
        $handler = $handlerWrapper['handler'];
        $this->returnData($this->convertReturnJsonSucessed(
            array('roomId'=>$handlerWrapper['roomId'],
                    'limitLevel'=>$handler->_limitLevel,
                    'limitLady'=>$handler->_limitLadyCount,
                    'limitMan'=>$handler->_limitMan,
                    'limitAngel'=>$handler->_limitAngel,
                    'members'=>$handler->getUsersArray())));    
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
                    $this->returnData($this->convertReturnJsonSucessed(
                            array('roomId'=>$handlerWrapper['roomId'],
                                'limitLevel'=>$handler->_limitLevel,
                                'limitLady'=>$handler->_limitLadyCount,
                                'limitMan'=>$handler->_limitMan,
                                'limitAngel'=>$handler->_limitAngel,
                                'members'=>$userArray)));
                    return;
                }                
            }
        }
        $this->returnData($this->convertReturnJsonError(JMessageController::ERROR_NO_MATCH
                    , 'can not match chartRoom'. '--'.$userName));
        return ;
    }
}
