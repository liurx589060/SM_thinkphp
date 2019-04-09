<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2019/3/19
 * Time: 21:40
 */

namespace Sample_Mjmz\Utils;


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
}