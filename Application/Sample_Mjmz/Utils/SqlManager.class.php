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

    private static function _createResultData($errorCode,$errorMsg) {
        $result[SqlManager::RESULT_ERRORCODE] = $errorCode;
        $result[SqlManager::RESULT_ERRORMSG] = $errorMsg;
        return $result;
    }

    //put your code here
    /**
     * 添加用户
     * @param type $userInfo
     * @return type
     */
    public static function insertUser($userInfo) {
        $sql = D(SqlManager::TABLE_USER);
        $d['userName'] = $userInfo['userName'];
        $d['password'] = $userInfo['password'];
        $errorCode = SqlManager::SQL_SUCCESS;
        $errorMsg = SqlManager::SQL_SUCCESS_STR;
        if(!empty($sql->where("userName='%s'",$d['userName'])->select())) {
            $errorCode = Common::ERROR_REGIST_EXIST;
            $errorMsg = 'user is exist,please change other userName';
        } else {
            $sql->add($d);
        }
        return SqlManager::_createResultData($errorCode, $errorMsg);
    }
}
