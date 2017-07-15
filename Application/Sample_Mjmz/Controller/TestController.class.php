<?php

/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

namespace Sample_Mjmz\Controller;
use Sample_Mjmz\Controller\BaseController;

define("PARAMS_PREFIX", 'user');
define('TABLE_USER', 'User');

class TestController extends BaseController {
    public function index(){
        echo 'you are my heart'.'-->>'.'Sy!';
    }
    
    public function hello($name='Sy') {
        $this->assign('name',$name);
        $this->display();
    }

        /**
     * 获取think_data表中所有数据
     */
    public function getUserData() {           
        $data = M(TABLE_USER);
        $result = $data->order('user_id')->select();
        $this->returnData($this->convertReturnJsonSucessed($result));
    }
    
    /**
     * 添加think_data表数据
     * @return type
     */
    public function addUser() {
        $data = D(TABLE_USER);
        $info = $_GET['userData'];       
        if(empty($info)) {
            $this->returnData($this->convertReturnJsonError(-1, '需要传入信息userData字段'));
            return;
        }
        $d['user_data'] = $info;
        $d['create_time'] = time();
        $result=$data->add($d);
        if($result) {
            $this->returnData($this->convertReturnJsonSucessed());
        }else{
            $this->returnData($this->convertReturnJsonError(10, '数据添加错误'));
        }
    }
    
    /**
     * 删除数据
     * @return type
     */
    public function deleteUser() {
        $key = $_GET['userData'];
        $id = $_GET['userId'];
        $data = M(TABLE_USER);
        if(!(empty($key) ^ empty($id))) {
            $this->returnData($this->convertReturnJsonError(-1, '不能同时有userData和userId参数，且必须有其一'));
            return;
        }
        

        $ret = FALSE;
        if(!empty($key)) {
           $ret = $data->where("user_data='%s'",$key)->delete();
        } else {
           $ret = $data->where('user_id=%d',$id)->delete();
        }
//        echo $data->getLastSql().'</br>';
        if($ret) {
            $this->returnData($this->convertReturnJsonSucessed());
        }else {
            $this->returnData($this->convertReturnJsonError(10, '删除出错'));
        }
    }
    
    /**
     * 更新数据
     * @param type $oldData
     * @param type $newData
     * @return type
     */
    public function updateUser() {
        $oldData = $_GET['oldData'];
        $newData = $_GET['newData'];
        if(!(!empty($oldData) && !empty($newData))) {
            $this->returnData($this->convertReturnJsonError(-1, 'oldData和newData为必填参数'));
            return;
        }
        
        $data = M(TABLE_USER);
        $d['user_data'] = $newData;
        $d['modify_time'] = time();
        $ret = $data->where("user_data='%s'",$oldData)->save($d);
        
//        echo $data->getLastSql().'</br>';
        if($ret) {
            $this->returnData($this->convertReturnJsonSucessed());
        }else {
            $this->returnData($this->convertReturnJsonError(10, '更新出错'));
        }
    }
}