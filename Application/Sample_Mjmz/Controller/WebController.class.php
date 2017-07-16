<?php

/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

namespace Sample_Mjmz\Controller;
use Sample_Mjmz\Controller\BaseController;

define('TABLE_USER', 'User');
define('TABLE_HEAD_IMAGE', 'Head_image');
define('TABLE_USER_INFO', 'User_info');

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
    
    /**
     * 上传
     */
    public function uploadByForm() {
        $userId = $_POST['user_id']; 
        if(empty($userId)) {
            $this->error('usrid必须填写');
            return;
        }
        $config = array(
            'maxSize'    =>    3145728,
            'rootPath'   =>    './',
            'savePath'   =>    'file/headImage/',
            'saveName'   =>    array('uniqid',''),
            'replace'    =>    true,
            'exts'       =>    array('jpg', 'gif', 'png', 'jpeg'),
            'autoSub'    =>    true,
            'subName'    =>    $userId,
        );
        $upload = new \Think\Upload($config);
        $User = M(TABLE_USER);
        $userInfo = $User->where('user_id=%d',$userId)->select();
        if($userInfo) {
            //上传
            $info = $upload->upload();
            if($info) {
                $Head_image = M(TABLE_HEAD_IMAGE);
                foreach ($info as $file) {                  
                    $d['head_image'] = $file['savepath'].$file['savename'];
                    $d['modify_time'] = time();
                    $User->where('user_id=%d',$userId)->save($d);
                    
                    $d['create_time'] = time(); 
                    $d['user_id'] = $userId;
                    $Head_image->add($d);
                    
                    $this->success('上传成功');
                } 
            }else {
                $this->error($upload->getError());
            }                                    
        } else {
            $this->error('没有该用户');
        }
    }
    
    /**
     * 添加用户详细数据
     * @return type
     */
    public function addUserInfoByForm() {
        $userId = $_POST['user_id'];
        if(empty($userId)) {
            $this->error('usrid必须填写');
            return;
        }
        
        $User = M(TABLE_USER);
        $UserInfo = D(TABLE_USER_INFO);
        $UserInfo->create();
        $isUser = $User->where('user_id=%d',$userId)->select();
        if(!$isUser) {
            $this->error('没有该用户');
            return;
        }
        
        $isUserFrInfo = $UserInfo->where('user_id=%d',$userId)->select();
        $result;
        if($isUserFrInfo) {
            $result = $UserInfo->where('user_id=%d',$userId)->save();
        } else {
            $result = $UserInfo->add();
        }
        echo $UserInfo->getLastSql();
        if($result) {
            $this->success('数据添加成功！');
        } else {
            $this->error('数据添加错误！');
        }     
    }
}

