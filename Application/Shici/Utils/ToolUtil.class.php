<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2019/3/19
 * Time: 21:40
 */

namespace Shici\Utils;


class ToolUtil
{
    public static function createUniqueNumber() {
        $str = date('Ymd').substr(implode(NULL, array_map('ord'
                , str_split(substr(uniqid(), 7, 13), 1))), 0, 8);
        return $str;
    }

    /**
     * 获取当前时间
     * @return false|string
     */
    public static function getCurrentTime() {
        return date("Y-m-d G:i:s");
    }

    /**
     * 通过时间戳转字符
     * @return false|string
     */
    public static function getTimeStrByTime($unixTime) {
        return date("Y-m-d G:i:s",$unixTime);
    }


    /**
     * 对象 转 数组
     *
     * @param object $obj 对象
     * @return array
     */
    public static function object_to_array($obj) {
        $obj = (array)$obj;
        foreach ($obj as $k => $v) {
            if (gettype($v) == 'resource') {
                return;
            }
            if (gettype($v) == 'object' || gettype($v) == 'array') {
                $obj[$k] = (array)object_to_array($v);
            }
        }

        return $obj;
    }

    /**
     * 数组 转 对象
     *
     * @param array $arr 数组
     * @return object
     */
    public static function array_to_object($arr) {
        if (gettype($arr) != 'array') {
            return;
        }
        foreach ($arr as $k => $v) {
            if (gettype($v) == 'array' || getType($v) == 'object') {
                $arr[$k] = (object)array_to_object($v);
            }
        }

        return (object)$arr;
    }
}