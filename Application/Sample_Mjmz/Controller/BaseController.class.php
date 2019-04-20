<?php

/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

namespace Sample_Mjmz\Controller;
use Think\Controller;
use Sample_Mjmz\Utils\Common;

define("JSON", 1);
define("XML", 0);

define("PARAMS_PREFIX", 'user');
define('TABLE_USER', 'User');
define('TABLE_HTML','Html');
define('TABLE_DEVICE','Device');

class BaseController extends Controller {
    private $formatType = array(JSON,XML);
    //默认的输出格式
    private $_DefaultType = JSON;


    public function convertReturnJsonSucessed($array=NULL,$extra=NULL) {
//        if(count($array) > 0) {
//            $callback['status'] = Common::SUCCESS;
//            $callback['msg'] = '操作成功';
//        }elseif (!isset ($array)) {//没有传值
//            $callback['status'] = Common::SUCCESS;
//            $callback['msg'] = '操作成功';
//        } else {//没有数据
//            $callback['status'] = 9000;
//            $callback['msg'] = '没有数据';
//        }

        if($array === false) {
            $callback['status'] = Common::ERROR;
            $callback['msg'] = '操作失败';
            return $callback;
        }

        $callback['status'] = Common::SUCCESS;
        $callback['msg'] = '操作成功';
        //额外的参数
        while ($key = key($extra)) {
            $callback[$key] = $extra[$key];
            next($extra);
        }
        
//        if(!empty($array)) {
//            $callback['data'] = $array;
//        }
        if(is_array($array) && empty($array)) {
            $callback['data'] = null;
        }else {
            $callback['data'] = $array;
        }
        return $callback;
    }
    
    public function convertReturnJsonError($status,$msg,$dataArray = null) {
        $callback['status'] = $status;
        $callback['msg'] = $msg;
        if($dataArray) {
            $callback['data'] = $dataArray;
        }
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
    
    /**
     * 验证公共参数和签名
     */
    public function checkPulicParams($method) {
        $checkResult = new CheckPulicResult();
        
        $imei = $_GET['imei'];
        $time = $_GET['time'];
        $signature = $_GET['signature'];
        $tempTime = time();
        if(empty($imei) || empty($time) || empty($signature)) {
            $this->returnData($this->convertReturnJsonError(-1, 'imei,time,signature参数不全'));
            $checkResult->checkResult = FALSE;
            return $checkResult;
        }
        $timeDelta = abs($tempTime - intval($time));
        if($timeDelta > 1*60) {
           $this->returnData($this->convertReturnJsonError(-1, '时间已过期'));
           $checkResult->checkResult = FALSE;
           return $checkResult; 
        }
        
        $Device = M(TABLE_DEVICE);
        $info = $Device->where("imei='%s'",$imei)->select();
        $checkResult->checkResult = TRUE;
        if(!$info) {//没有记录
            $tempToken = $this->getRandChar(16);
            $Device->imei = $imei;
            $Device->token = $tempToken;
            $Device->create_time = time();
            $Device->modify_time = time();
            $Device->add();
            
            $checkResult->token = $tempToken;
        } else {//存在则比较          
            $info = $info[0];
            $token = $info['token'];
            $ctTimeDelta = intval(time()) - intval($info['modify_time']);
            $tempSignature = md5($method.$token.$time);
//            echo $method.$token.$time;
            if($tempSignature == $signature) {             
                if($ctTimeDelta > 6*60*60) {//超过时间修改token
                    $tempToken = $this->getRandChar(16);
                    $Device->modify_time = time();
                    $Device->token = $tempToken;
                    $Device->where("imei='%s'",$imei)->save();
                    $checkResult->token = $tempToken;                  
                }                            
            } else {
                $this->returnData($this->convertReturnJsonError(10, 'signature不对')); 
                $checkResult->checkResult = FALSE;
            }                      
        }
        
        return $checkResult;
    }
    
    private function getRandChar($length){
        $str = null;
        $strPol = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789abcdefghijklmnopqrstuvwxyz";
        $max = strlen($strPol)-1;

        for($i=0;$i<$length;$i++){
        $str.=$strPol[rand(0,$max)];//rand($min,$max)生成介于min和max两个数之间的一个随机整数
   }

   return $str;
  }
}

class CheckPulicResult {
    public $checkResult = False;
    public $token;
}

