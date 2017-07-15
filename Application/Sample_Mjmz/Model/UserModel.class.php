<?php

/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
namespace Sample_Mjmz\Model;
use Think\Model;

class UserModel extends Model {
    // 定义自动验证
    protected $_validate    =   array(
        array('user_data','require','内容必须'),
        array('user_id','require','修改时id必须'),
        );
    // 定义自动完成
    protected $_auto    =   array(
        array('create_time','time',1,'function'),
        );
}

