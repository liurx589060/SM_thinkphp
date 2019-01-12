<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

namespace Sample_Mjmz\Utils;

/**
 * Description of Common
 *
 * @author Administrator
 */
class Common {
    const SUCCESS = 0;
    //put your code here
    const ERROR_NO_MATCH = 7000;//未匹配上
    const ERROR_EXIT_CHARTROOM = 7001;//退出失败
    const ERROR_LACK_PARAMS = 7002;//缺少参数
    const ERROR_DELETE_CHARTEOOM = 7003;//删除聊天室失败
    const ERROR_CREATE_CHARTEOOM = 7004;//创建聊天室失败
    const ERROR_JOIN_CHARTEOOM = 7005;//创建聊天室失败
    
    const ERROR_USER_REGIST = 7100;//注册失败
    const ERROR_USER_REGIST_EXIST = 7101;//已经存在账户
    const ERROR_USER_NOT_EXIST = 7102;//账号不存在
    const ERROR_USER_UPLOAD = 7103;//上传文件出错
    const ERROR_USER_PASSWORD_WRONG = 7104;//密码错误
    const ERROR_USER_PASSWORD_CHANGE = 7105;//修改密码出错


    const MAN = '男';  //男士
    const LADY = '女'; //女生
    const ANGEL = '天使'; //天使
    const FULL = ''; //满员
    
    const ROLRTYPE_ANGEL = 'angel';
    const ROLETYPE_GUEST = 'guest';
}
