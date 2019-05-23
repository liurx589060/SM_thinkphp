<?php

/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

namespace Shici\Controller;
use Think\Controller;
use Shici\Utils\Common;

define("JSON", 1);
define("XML", 0);

define("PARAMS_PREFIX", 'user');
define('TABLE_USER', 'User');
define('TABLE_HTML','Html');
define('TABLE_DEVICE','Device');

class BaseController extends Controller
{
    private $formatType = array(JSON, XML);
    //默认的输出格式
    private $_DefaultType = JSON;


    public function convertReturnJsonSucessed($array = NULL, $extra = NULL)
    {
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

        if ($array === false) {
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
        if (is_array($array) && empty($array)) {
            $callback['data'] = null;
        } else {
            $callback['data'] = $array;
        }
        return $callback;
    }

    public function convertReturnJsonError($status = Common::ERROR, $msg = "operate error", $dataArray = null)
    {
        $callback['status'] = $status;
        $callback['msg'] = $msg;
        if ($dataArray) {
            $callback['data'] = $dataArray;
        }
        return $callback;
    }

    public function returnData($callback)
    {
        $type = $_GET['type'];
        $ret = in_array($type, $this->formatType);
        $isNull = $type == NULL;
        $boolen = $isNull || (!$isNull && !$ret);
        $temp = $boolen ? $this->_DefaultType : intval($type);
        $formatType = ($temp == JSON) ? 'json' : 'xml';
        $this->ajaxReturn($callback, $formatType);
    }
}

