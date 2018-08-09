<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

namespace Sample_Mjmz\Utils;

/**
 * Description of SqlManager
 *
 * @author Administrator
 */
class SqlManager {
    const SQL_NAME = 'xq_app';
    const TABLE_USER = 'user';
    const TABLE_USERINFO = 'user_info';
    
    const SQL_SUCCESS_STR = 'sql_success';
    const SQL_SUCCESS = 200;


    const RESULT_ERRORCODE = 'errorCode';
    const RESULT_ERRORMSG = 'errorMsg';

    private static function _createResultError($errorCode,$errorMsg) {
        $result[SqlManager::RESULT_ERRORCODE] = $errorCode;
        $result[SqlManager::RESULT_ERRORMSG] = $errorMsg;
        return $result;
    }
    
    private static function _createResultSuccess($msg=NULL) {
        $result[SqlManager::RESULT_ERRORCODE] = SqlManager::SQL_SUCCESS;
        $result[SqlManager::RESULT_ERRORMSG] = is_null($msg)?SqlManager::SQL_SUCCESS_STR:$msg;
        return $result;
    }

    //put your code here
    /**
     * 添加用户
     * @param type $userInfo
     * @return type
     */
    public static function insertUser($userInfo) {
        $sql = M(SqlManager::TABLE_USER);
        $d['user_name'] = $userInfo['userName'];
        $d['password'] = $userInfo['password'];
        $d['create_time'] = date("Y-m-d G:i:s");
        if(SqlManager::checkUserExist(SqlManager::TABLE_USER,$d)) {
            return SqlManager::_createResultError(Common::ERROR_USER_REGIST_EXIST, 'user is already exist');
        }
        if(!$sql->add($d)) {
            return SqlManager::_createResultError(Common::ERROR_REGIST, 'insert user error');
        }
        return SqlManager::_createResultSuccess($sql->where("user_name='%s'",$d['user_name'])
                ->field(array('user_id','user_name'))->find());
    }
    
    public static function login($userInfo) {
        $d['user_name'] = $userInfo['userName'];
        $d['password'] = $userInfo['password'];
        $sql = M(SqlManager::TABLE_USER);
        //检测是否存在该用户
        if(!SqlManager::checkUserExist(SqlManager::TABLE_USER,$d)) {
            return SqlManager::_createResultError(Common::ERROR_USER_REGIST_UNEXIST
                    , 'the user is not exist');
        }
        $result = $sql->where("user_name='%s'",$d['user_name'])->find();
        if($d['password'] == $result['password']) {
            return SqlManager::_createResultSuccess(SqlManager::getUserInfoBySql($d));
        }
        return SqlManager::_createResultError(Common::ERROR_USER_PASSWORD_WRONG
                , 'password is wrong');
    }

    public static function checkUserExist($tableName,$userInfo) {
        $d['user_name'] = $userInfo['user_name'];
        if(is_null($d['user_name'])) {
            $d['user_name'] = $userInfo['userName'];
        }
        $sql = M($tableName);
        $result = $sql->where("user_name='%s'",$d['user_name'])->select();
        if(empty($result)) {
            return false;
        }
        return $result[0];
    }
    
    public static function updateUserInfo($userInfo) {
        $ex['user_name'] =$userInfo['userName'] ;
        $ex['nick_name'] = $userInfo['nickName'];
        $fianlArray = $userInfo + $ex;    
        $sql = M(SqlManager::TABLE_USERINFO);
        //检测是否存在该用户
        $result = SqlManager::checkUserExist(SqlManager::TABLE_USER,$fianlArray);
        if(!$result) {
            return SqlManager::_createResultError(Common::ERROR_USER_REGIST_UNEXIST
                    , 'the user is not exist');
        }
        $fianlArray['user_id'] = $result['user_id'];
        //进行更新或者插入
        if(empty($sql->where("user_name='%s'",$fianlArray['user_name'])->select())) {
            $fianlArray['create_time'] = date("Y-m-d G:i:s");
            $sql->add($fianlArray);
        }else {
            $fianlArray['modify_time'] = date("Y-m-d G:i:s");
            $sql->where("user_name='%s'",$fianlArray['user_name'])->save($fianlArray);
        }
        //获取用户信息
        $sqlInfo = SqlManager::getUserInfoBySql($fianlArray);
        return SqlManager::_createResultSuccess($sqlInfo);
    }

    public static function uploadFile($userInfo)
    {
        $d['user_name'] = $userInfo['userName'];
        if(!SqlManager::checkUserExist(SqlManager::TABLE_USER, $d)) {
            return SqlManager::_createResultError(Common::ERROR_USER_REGIST_UNEXIST
                    , 'the user is not exist'); 
        }
            
        $base_path = "/upload/XQ/"; //存放目录  
        if(!is_dir($base_path)){  
            mkdir($base_path,0777,true);  
        }  
        $target_path = $base_path.basename($_FILES['uploadFile'] ['name'] );  
        if (move_uploaded_file($_FILES['uploadFile']['tmp_name'],'.'.$target_path )) {  
//            $d['head_image'] = 'http://'.$_SERVER['SERVER_NAME'].'/thinkphp'.$target_path;
            $d['head_image'] = '/thinkphp'.$target_path;
            return SqlManager::updateUserInfo($d);
        } else {  
            return SqlManager::_createResultError(Common::ERROR_USER_UPLOAD
                    , "There was an error uploading the file, please try again!" . $_FILES ['attach'] ['error']); 
        }  
    }
    
    public static function getUserInfoBySql($userInfo) {
        $user_name = isset($userInfo['user_name'])?$userInfo['user_name']:$userInfo['userName'];
        $sql = M(SqlManager::TABLE_USERINFO);   
        $sqlInfo = $sql->where("user_name='%s'",$user_name)
                ->field('id',true)->find();
        $sqlInfo['head_image'] = 'http://'.$_SERVER['SERVER_NAME'].$sqlInfo['head_image'];
        return $sqlInfo;
    }
}
