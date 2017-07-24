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
define('TABLE_HTML','Html');

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
        $result = $data
                ->join('LEFT JOIN __USER_INFO__ ON __USER_INFO__.user_id=__USER__.user_id')
                ->field('think_user.user_id,think_user.user_data,think_user.head_image'
                        . ',think_user_info.age,think_user_info.sex,think_user_info.house_address'
                        . ',think_user_info.job_address,think_user.create_time,think_user.modify_time')
                ->order('think_user.user_id')
                ->select();
//        echo $data->getLastSql();
        
        $userList = array();
        $i = 0;
        foreach ($result as $r) {
            $image_prefix = empty($r['head_image']) ?'':'http://'.$_SERVER['SERVER_NAME'].'/thinkphp/';                           
            $r['head_image'] = $image_prefix.$r['head_image'];
            
            $info['age'] = $r['age'];
            $info['sex'] = $r['sex'];
            $info['house_address'] = $r['house_address'];
            $info['job_address'] = $r['job_address'];
            
            $single['user_id'] = $r['user_id'];
            $single['user_data'] = $r['user_data'];
            $single['head_image'] = $r['head_image'];
            $single['info'] = $info;
            $single['create_time'] = $r['create_time'];
            $single['modify_time'] = $r['modify_time'];
            
            $userList[$i] = $single;
            $i++;
        }
        $this->returnData($this->convertReturnJsonSucessed($userList));
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
    
    /**
     * 获取html文档
     */
    public function getHtml() {
        $id = $_GET['id'];
        if(empty($id)) {
            $this->returnData($this->convertReturnJsonError(-1, 'id为必填参数'));
            return;
        }
        
        $fh= file_get_contents('http://localhost/thinkphp/Sample_Mjmz/web/madridNews?id='.$id);
        
        $Html = M(TABLE_HTML);
        $result = $Html->where("id='%d'",$id)->select();
        $result = $result[0];
        if($result) {
            $array['id'] = $result['id'];
            $data['key_word'] = $result['key_word'];
            $data['css'] = $result['css'];
            $data['javascript'] = $result['javascript'];
            $data['html'] = $result['html'];
            $data['full_code'] = $str = str_replace(array("\r\n", "\r", "\n"), "", $fh);  //去掉回车
            $array['model'] = $data;       
           
            $this->returnData($this->convertReturnJsonSucessed($array));
        } else {
            $this->returnData($this->convertReturnJsonError(10, '出错,请检查参数是否正确'));
        }    
    }
}