<?php

/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
namespace Sample_Mjmz\Controller;
use Sample_Mjmz\Controller\BaseController;
use Sample_Mjmz\Utils\Common;
use Sample_Mjmz\Utils\SqlManager;

class UserController extends BaseController {

    public function index(){
       echo 'welcome to User'.'-->>'.'Sy!';
    }
    
    private function _returnError($result) {
        $this->returnData($this->convertReturnJsonError($result[SqlManager::RESULT_ERRORCODE]
                    , $result[SqlManager::RESULT_ERRORMSG]));
    }

    /**
     * http://localhost/thinkphp/Sample_Mjmz/user/regist?userName=aaa&password=123456&type=0
     * 注册
     * @param type $userInfo
     */
    public function regist($userInfo = array()) {
        if(!isset($userInfo['userName'])) {
            $userInfo['userName'] = $_GET['userName'];
        }
        if(!isset($userInfo['password'])) {
            $userInfo['password'] = $_GET['password'];
        }
        if(is_null($userInfo['userName'])||is_null($userInfo['password'])) {
            $this->returnData($this->convertReturnJsonError(Common::ERROR_LACK_PARAMS
                    , 'lack userName or password'));
        }
        $sqlResult = SqlManager::insertUser($userInfo);
        if($sqlResult[SqlManager::RESULT_ERRORCODE] == SqlManager::SQL_SUCCESS) {
            $this->returnData($this->convertReturnJsonSucessed($sqlResult[SqlManager::RESULT_ERRORMSG]));
        } else {
            $this->_returnError($sqlResult);
        }
    }
    
    /**
     * http://localhost/thinkphp/Sample_Mjmz/user/login?userName=aaa&password=123456&type=0
     * 登陆
     * @param type $userInfo
     */
    public function login($userInfo = array()) {
        $userInfo['userName'] = isset($userInfo['userName'])?$userInfo['userName']:$_GET['userName'];
        $userInfo['password'] = isset($userInfo['password'])?$userInfo['password']:$_GET['password'];
        $sqlResult = SqlManager::login($userInfo);
        if($sqlResult[SqlManager::RESULT_ERRORCODE] == SqlManager::SQL_SUCCESS) {
            $this->returnData($this->convertReturnJsonSucessed($sqlResult[SqlManager::RESULT_ERRORMSG]));
        } else {
            $this->_returnError($sqlResult);
        }
    }

        /**
     * http://localhost/thinkphp/Sample_Mjmz/user/checkUserExist?userName=aaa&type=0
     * 检查是否注册过
     * @param type $userInfo
     */
    public function checkUserExist($userInfo = array()) {
        if(!isset($userInfo['userName'])) {
            $userInfo['userName'] = $_GET['userName'];
        }
        if(is_null($userInfo['userName'])) {
            $this->returnData($this->convertReturnJsonError(Common::ERROR_LACK_PARAMS
                    , 'lack userName'));
        }
        if(SqlManager::checkUserExist(SqlManager::TABLE_USER,$userInfo)) {
            $this->returnData($this->convertReturnJsonSucessed('用户存在'));
        } else {
            $this->returnData($this->convertReturnJsonError(Common::ERROR_USER_NOT_EXIST,'user is not exist'));
        }
    }

    /**
     * http://localhost/thinkphp/Sample_Mjmz/user/getUserInfoByUserName?userName=wys30201
     *获取用户信息
     */
    public function getUserInfoByUserName() {
        $userName = $_GET['userName'];
        if(is_null($userName)) {
            $this->returnData($this->convertReturnJsonError(Common::ERROR_LACK_PARAMS
                , 'lack userName'));
            return ;
        }

        $userInfo['user_name'] = $userName;
        $sqlResult = SqlManager::getUserInfo($userInfo);
        $this->returnData($this->convertReturnJsonSucessed($sqlResult));
    }
    
    /**
     * http://localhost/thinkphp/Sample_Mjmz/user/checkUserRegist?userName=aaa&type=0
     * @param type $userInfo
     */
    public function updateUserInfo($userInfo = array()) {
        $userInfo['userName'] = isset($userInfo['userName'])?$userInfo['userName']:$_GET['userName'];
        $userInfo['nickName'] = isset($userInfo['nickName'])?$userInfo['nickName']:$_GET['nickName'];
        $userInfo['gender'] = isset($userInfo['gender'])?$userInfo['gender']:$_GET['gender'];
        $userInfo['age'] = isset($userInfo['age'])?$userInfo['age']:$_GET['age'];
        $userInfo['tall'] = isset($userInfo['tall'])?$userInfo['tall']:$_GET['tall'];
        $userInfo['scholling'] = isset($userInfo['scholling'])?$userInfo['scholling']:$_GET['scholling'];
        $userInfo['professional'] = isset($userInfo['professional'])?$userInfo['professional']:$_GET['professional'];
        $userInfo['native_place'] = isset($userInfo['native_place'])?$userInfo['native_place']:$_GET['native_place'];
        $userInfo['marrige'] = isset($userInfo['marrige'])?$userInfo['marrige']:$_GET['marrige'];
        $userInfo['job_address'] = isset($userInfo['job_address'])?$userInfo['job_address']:$_GET['job_address'];
        $userInfo['phone'] = isset($userInfo['phone'])?$userInfo['phone']:$_GET['phone'];
        $userInfo['role_type'] = isset($userInfo['role_type'])?$userInfo['role_type']:$_GET['role_type'];
//        $userInfo['head_image'] = isset($userInfo['head_image'])?$userInfo['head_image']:$_GET['head_image'];
        $userInfo['special_info'] = isset($userInfo['special_info'])?$userInfo['special_info']:$_GET['special_info'];
        if(is_null($userInfo['userName'])) {
            $this->returnData($this->convertReturnJsonError(Common::ERROR_LACK_PARAMS
                    , 'lack userName'));
        }
        $sqlResult = SqlManager::updateUserInfo($userInfo);
        if($sqlResult[SqlManager::RESULT_ERRORCODE] == SqlManager::SQL_SUCCESS) {
            $this->returnData($this->convertReturnJsonSucessed($sqlResult[SqlManager::RESULT_ERRORMSG]));
        } else {
            $this->_returnError($sqlResult);
        }
    }
    
    /**
     * Post
     * http://localhost/thinkphp/Sample_Mjmz/user/uploadHeadImage
     * 上传头像
     */
    public function uploadHeadImage($userInfo=array()) {
        $userInfo['userName'] = isset($userInfo['userName'])?$userInfo['userName']:$_POST['userName'];
        $sqlResult = SqlManager::uploadFile($userInfo);
        if($sqlResult[SqlManager::RESULT_ERRORCODE] == SqlManager::SQL_SUCCESS) {
            $this->returnData($this->convertReturnJsonSucessed($sqlResult[SqlManager::RESULT_ERRORMSG]));
        } else {
            $this->_returnError($sqlResult);
        }
    }
    
    /**
     * 举报用户
     * http://localhost/thinkphp/Sample_Mjmz/user/reportUser?userName=aaa&type=0&reportType=1&reportMsg=谩骂&roomId=1458967
     */
    public function reportUser() {
        $userName = $_GET['userName'];
        $reportType = $_GET['reportType'];
        $reportMsg = $_GET['reportMsg'];
        $roomId = $_GET['roomId'];
        if(is_null($userName) || is_null($reportType) || is_null($reportMsg) || is_null($roomId)) {
            $this->returnData($this->convertReturnJsonError(Common::ERROR_LACK_PARAMS
                    , 'lack userName,reportType,reportMsg,roomId'));
            return ;
        }
        
        $userInfo['userName'] = $userName;
        $sqlResult = SqlManager::checkUserExist(SqlManager::TABLE_USER,$userInfo);
        if($sqlResult) {
            $sqlData['user_name'] = $userName;
            $sqlData['report_type'] = $reportType;
            $sqlData['report_msg'] = $reportMsg;
            $sqlData['room_id'] = $roomId;
            $sqlData['time'] = ToolUtil::getCurrentTime();
            
            if(SqlManager::reportUser($sqlData)) {
                $this->returnData($this->convertReturnJsonSucessed('举报成功'));
            }else {
                $this->returnData($this->convertReturnJsonError(Common::ERROR,'reportUser error'));
            }
        }else {
            $this->returnData($this->convertReturnJsonError(Common::ERROR_USER_NOT_EXIST,'user not exit'));
        }
    }
    
    /**
     * 举报用户
     * 1:禁止状态   0：解禁状态   -1：所有状态
     * http://localhost/thinkphp/Sample_Mjmz/user/getBlackUserByName?userName=aaa&status=1
     */
    public function getBlackUserByName() {
        $userName = $_GET['userName'];
        $status = $_GET['status'];
        if(is_null($userName) || is_null($status)) {
            $this->returnData($this->convertReturnJsonError(Common::ERROR_LACK_PARAMS , 'lack userName，status'));
            return ;
        }
        
        $userInfo['userName'] = $userName;
        $userInfo['status'] = $status;
        $sqlResult = SqlManager::getBlackUserByName($userInfo);
        
        $this->returnData($this->convertReturnJsonSucessed($sqlResult));
    }
    
    /**
     * 获取举报项
     * http://localhost/thinkphp/Sample_Mjmz/user/getReportItems
     */
    public function getReportItems() {
        $count = count(Common::REPORT_ITEMS);
        $date = array();
        for($index = 0 ; $index < $count ; $index ++) {
            $info['id'] = $index+1;
            $info['item'] = Common::REPORT_ITEMS[$index];
            $date[$index] = $info;
        }
        $this->returnData($this->convertReturnJsonSucessed($date));
    }
    
    /**
     * 添加好友
     * http://localhost/thinkphp/Sample_Mjmz/user/addFriend?userName=wys30201&targetName=wys30204&roomId=124587
     * @param type $param
     * @param type $Net   false:内部调用   true：网络接口传入
     */
    public function addFriend($param = array(),$Net = TRUE) {
        $data = array();
        if($Net) {
            $data['userName'] = $_GET['userName'];
            $data['targetName'] = $_GET['targetName'];
            $data['roomId'] = $_GET['roomId'];
        }else {
            $data['userName'] = $param['userName'];
            $data['targetName'] = $param['targetName'];
            $data['roomId'] = $param['roomId'];
        }
        
        if(is_null($data['userName']) || is_null($data['targetName'])) {
            $this->returnData($this->convertReturnJsonError(Common::ERROR_LACK_PARAMS , 'lack userName ,targetName'));
        }
        
        if(is_null($data['roomId'])) {
            $data['roomId'] = '';
        }
        
        $userInfo['user_name'] = $data['userName'];
        if(!SqlManager::checkUserExist(SqlManager::TABLE_USER, $userInfo)) {
            $this->returnData($this->convertReturnJsonError(Common::ERROR_USER_NOT_EXIST , $userInfo['user_name'].'不存在'));
        }
        
        $userInfo['user_name'] = $data['targetName'];
        if(!SqlManager::checkUserExist(SqlManager::TABLE_USER, $userInfo)) {
            $this->returnData($this->convertReturnJsonError(Common::ERROR_USER_NOT_EXIST , $userInfo['user_name'].'不存在'));
        }
        
        if($data['userName'] === $data['targetName']) {
            $this->returnData($this->convertReturnJsonError(Common::ERROR_PARAMS_SAME , $userInfo['user_name'].'不可添加自己'));
        }
        
        $result = SqlManager::addFriend($data);
        if($result) {
            $this->returnData($this->convertReturnJsonSucessed('添加好友成功'));
        }else {
            $this->returnData($this->convertReturnJsonError(Common::ERROR , '添加好友失败'));
        }
    }
    
    /**
     * 获取用户信息
     * http://localhost/thinkphp/Sample_Mjmz/user/getUserInfo?userName=wys30201
     * @param type $param
     * @param type $Net   false:内部调用   true：网络接口传入
     */
    public function getUserInfo($param = array(),$Net = TRUE) {
        $userName = '';
        if($Net) {
            $userName = $_GET['userName'];
        }else {
            $userName = $param['user_name'];
        }
        
        if(is_null($userName)) {
            $this->returnData($this->convertReturnJsonError(Common::ERROR_LACK_PARAMS , 'lack userName'));
        }
        
        $userInfo['user_name'] = $userName;
        if(!SqlManager::checkUserExist(SqlManager::TABLE_USER, $userInfo)) {
            $this->returnData($this->convertReturnJsonError(Common::ERROR_USER_NOT_EXIST , $userInfo['user_name'].'不存在'));
        }
        
        $sqlData['user_name'] = $userName;
        $result = SqlManager::getUserInfo($sqlData);
        if($result) {
            $this->returnData($this->convertReturnJsonSucessed($result));
        }else {
            $this->returnData($this->convertReturnJsonError(Common::ERROR , '查询失败'));
        }
    }
    
    /**
     * 获取用户好友列表
     * http://localhost/thinkphp/Sample_Mjmz/user/getFriendListByUser?userName=wys30201
     * @param type $param
     * @param type $Net   false:内部调用   true：网络接口传入
     */
    public function getFriendListByUser($param = array(),$Net = TRUE) {
        $userName = '';
        if($Net) {
            $userName = $_GET['userName'];
        }else {
            $userName = $param['userName'];
        }
        
        if(is_null($userName)) {
            $this->returnData($this->convertReturnJsonError(Common::ERROR_LACK_PARAMS , 'lack userName'));
        }
        
        $userInfo['user_name'] = $userName;
        if(!SqlManager::checkUserExist(SqlManager::TABLE_USER, $userInfo)) {
            $this->returnData($this->convertReturnJsonError(Common::ERROR_USER_NOT_EXIST , $userInfo['user_name'].'不存在'));
        }
        
        $sqlData['userName'] = $userName;
        $result = SqlManager::getFriendListByUser($sqlData);
        $this->returnData($this->convertReturnJsonSucessed($result));
    }
}

