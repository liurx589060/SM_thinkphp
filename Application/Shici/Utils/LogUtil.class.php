<?php
/**
 * Created by PhpStorm.
 * User: liurunxiong
 * Date: 2019/4/12
 * Time: 15:26
 */

namespace Shici\Utils;
use Think\Log;

class LogUtil
{
    const LogPath = LOG_PATH.'self/';

    /**写入app一般日志
     * @param $message
     * @param string $level
     * @param string $type
     * @param string $extra
     */
    public static function writeAppLog($message,$level=Log::INFO,$type='',$extra='') {
        Log::write($message,$level,$type,self::LogPath.'app.log',$extra);
    }

    /**写入app 支付回调日志
     * @param $message
     * @param string $level
     * @param string $type
     * @param string $extra
     */
    public static function writePayCallbackLog($message,$level=Log::INFO,$type='',$extra='') {
        Log::write($message,$level,$type,self::LogPath.'pay.log',$extra);
    }
}