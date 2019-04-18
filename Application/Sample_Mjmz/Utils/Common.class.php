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
    const JM_appKey = '2f3cff28d0bcc572927bf624';                           //极光appkey
    const JM_masterSecret = 'cd7be344156c9afc0d218bad';                     //极光Secret
    const TrPay_appKey = 'e08c9287fc9b4f8990c254457820141a';                        //TrPay appkey
    const TrPay_masterSecret = '22e2bc4499e94b65b9b9c60384c3deb5';          //TrPay Secret

    const SUCCESS = 0;
    const ERROR = -1;
    //put your code here
    const ERROR_NO_MATCH = 7000;//未匹配上
    const ERROR_EXIT_CHARTROOM = 7001;//退出失败
    const ERROR_LACK_PARAMS = 7002;//缺少参数
    const ERROR_DELETE_CHARTEOOM = 7003;//删除聊天室失败
    const ERROR_CREATE_CHARTEOOM = 7004;//创建聊天室失败
    const ERROR_JOIN_CHARTEOOM = 7005;//创建聊天室失败
    const ERROR_ALREADY_APPOINT_CHATROOM = 7006;//已经有预约的房间
    const ERROR_NOT_FIND_CHATROOM = 7007; //找不到房间
    const ERROR_FULL_CHATROOM = 7008; //房间满员
    const ERROR_ALREADY_START_CHATROOM = 7009; //房间已开始
    const ERROR_ROLETYPE_NOT_MATCH = 7010; //角色身份不对
    const ERROR_ALREADY_JOIN_CHATROOM = 7011;//已经加入过房间
    
    const ERROR_USER_REGIST = 7100;//注册失败
    const ERROR_USER_REGIST_EXIST = 7101;//已经存在账户
    const ERROR_USER_NOT_EXIST = 7102;//账号不存在
    const ERROR_USER_UPLOAD = 7103;//上传文件出错
    const ERROR_USER_PASSWORD_WRONG = 7104;//密码错误
    const ERROR_USER_PASSWORD_CHANGE = 7105;//修改密码出错
    const ERROR_PARAMS_SAME = 7106;//参数相同
    const ERROR_LACK_STOCK = 7107;//库存不够

    //极光推送
    const JPUSH_TAG_CHAT = 'tag_chat_room';  //标签
    const JPUSH_TYPE_CHAT_ROOM_CREATE = 1;   //创建房间
    const JPUSH_TYPE_CHAT_ROOM_DELETE = 2;   //删除房间

    const JPUSH_TYPE_PAY_SUCCESS = 100;      //支付成功


    const MAN = '男';  //男士
    const LADY = '女'; //女生
    const ANGEL = '天使'; //天使
    const FULL = ''; //满员

    const CHAT_ROOM_ROLETYPE_PARTICIPANTS = 1; //参与者
    const CHAT_ROOM_ROLETYPE_ONLOOKER = 2; //围观者
    
    const ROLRTYPE_ANGEL = 'angel';
    const ROLETYPE_GUEST = 'guest';
    
    const BLACK_BAN_BASE_TIME = 6; //6小时
    
    const REPORT_ITEMS = array('故意长时间挂机或离线','注册信息违规','言语或视频违背伦理');
    
}
