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
}