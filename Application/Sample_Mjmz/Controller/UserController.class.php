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
     * http://localhost/thinkphp/Sample_Mjmz/user/checkUserRegist?userName=aaa&type=0
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
        if(SqlManager::checkUserExist($userInfo)) {
            $this->returnData($this->convertReturnJsonSucessed('用户存在'));
        } else {
            $this->returnData($this->convertReturnJsonError(Common::ERROR_USER_REGIST_UNEXIST,'user is not exist'));
        }
    }
    
    /**
     * http://localhost/thinkphp/Sample_Mjmz/user/checkUserRegist?userName=aaa&type=0
     * @param type $userInfo
     */
    public function updateUserInfo($userInfo = array()) {
        $userInfo['userName'] = isset($userInfo['userName'])?$userInfo['userName']:$_GET['userName'];
        $userInfo['nickName'] = isset($userInfo['nickName'])?$userInfo['nickName']:$_GET['nickName'];
        $userInfo['gender'] = isset($userInfo['gender'])?$userInfo['gender']:$_GET['gender'];
//        $userInfo['head_image'] = isset($userInfo['head_image'])?$userInfo['head_image']:$_GET['head_image'];
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
}

