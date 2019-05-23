<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

namespace Shici\Utils;

/**
 * Description of Common
 *
 * @author Administrator
 */
class Common {
    const SUCCESS = 0;
    const ERROR = -1;
    //put your code here
    const ERROR_LACK_PARAMS = 7002;//缺少参数
    const ERROR_USER_REGIST = 7100;//注册失败
    const ERROR_USER_REGIST_EXIST = 7101;//已经存在账户
    const ERROR_USER_NOT_EXIST = 7102;//账号不存在
    const ERROR_USER_PASSWORD_WRONG = 7104;//密码错误
    const ERROR_USER_PASSWORD_CHANGE = 7105;//修改密码出错
    const ERROR_PARAMS_SAME = 7106;//参数相同
    const ERROR_LACK_STOCK = 7107;//库存不够

    //极光推送
    const JPUSH_TYPE_PAY_SUCCESS = 100;      //支付成功
}
