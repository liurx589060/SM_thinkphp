<?php

/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

namespace Sample_Mjmz\Controller;
use Think\Controller;

define("JSON", 1);
define("XML", 0);

class BaseController extends Controller {
    private $formatType = array(JSON,XML);
    //默认的输出格式
    private $_DefaultType = XML;


    protected function convertReturnJsonSucessed($array=NULL) {
        if(count($array) > 0) {
            $callback['status'] = 0;
            $callback['msg'] = '操作成功'; 
        }elseif (!isset ($array)) {//没有传值
            $callback['status'] = 0;
            $callback['msg'] = '操作成功'; 
        } else {//没有数据
            $callback['status'] = 9000;
            $callback['msg'] = '没有数据';
        }
        if(!empty($array)) {
            $callback['data'] = $array;
        }
        return $callback;
    }
    
    protected function convertReturnJsonError($status,$msg) {
        $callback['status'] = $status;
        $callback['msg'] = $msg;
        return $callback;
    }
    
    public function returnData($callback) {
        $type = $_GET['type']; 
        $ret = in_array($type, $this->formatType);
        $isNull = $type == NULL;
        $boolen = $isNull || (!$isNull && !$ret);       
        $temp = $boolen?$this->_DefaultType:intval($type);
//        echo $temp;
        $formatType = ($temp == JSON)?'json':'xml';
        $this->ajaxReturn($callback, $formatType);
    }
}

