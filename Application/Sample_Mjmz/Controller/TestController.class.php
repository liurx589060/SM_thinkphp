<?php

/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

namespace Sample_Mjmz\Controller;
use Sample_Mjmz\Controller\BaseController;
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
        $data = M('Data');
        $result = $data->order('id')->select();
        $this->returnData($this->convertReturnJsonSucessed($result));
    }
    
    /**
     * 添加think_data表数据
     * @return type
     */
    public function addUser() {
        $data = D('Data');
        $info = $_GET['info'];       
        if(empty($info)) {
            $this->returnData($this->convertReturnJsonError(-1, '需要传入信息info字段'));
            return;
        }
        $d['data'] = $info;
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
        $key = $_GET['data'];
        $id = $_GET['id'];
        $data = M('Data');
        if(!(empty($key) ^ empty($id))) {
            $this->returnData($this->convertReturnJsonError(-1, '不能同时有data和id参数，且必须有其一'));
            return;
        }
        

        $ret = FALSE;
        if(!empty($key)) {
           $ret = $data->where("data='%s'",$key)->delete();
        } else {
           $ret = $data->where('id=%d',$id)->delete();
        }
        echo $data->getLastSql().'</br>';
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
        
        $data = M('Data');
        $d['data'] = $newData;
        $ret = $data->where("data='%s'",$oldData)->save($d);
        
        echo $data->getLastSql().'</br>';
        if($ret) {
            $this->returnData($this->convertReturnJsonSucessed());
        }else {
            $this->returnData($this->convertReturnJsonError(10, '更新出错'));
        }
    }
}