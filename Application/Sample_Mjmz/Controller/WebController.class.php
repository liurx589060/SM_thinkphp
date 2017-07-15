<?php

/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

namespace Sample_Mjmz\Controller;
use Sample_Mjmz\Controller\BaseController;

define('TABLE_USER', 'User');

class WebController extends BaseController {
    public function index(){
        echo 'Welcome WebController';
    }
    
    /**
     * 通过网页表单添加用户
     */
    public function addUserByForm() {
        $User = D(TABLE_USER);
        if($User->create()) {
            $result = $User->add();
            if($result) {
                $this->success('数据添加成功！');
            } else {
                $this->error('数据添加错误！');
            }
        } else {
            $this->error($User->getError());
        }
    }
    
    /**
     * 通过网页表单修改用户
     */
    public function updataUserByForm() {
        $User = D(TABLE_USER);
        if($User->create()) {
            $User->modify_time = time();
            $result = $User->save();
            if($result) {
                $this->success('数据修改成功！');
            } else {
                $this->error('数据修改错误！');
            }
        } else {
            $this->error($User->getError());
        }
    }
}

