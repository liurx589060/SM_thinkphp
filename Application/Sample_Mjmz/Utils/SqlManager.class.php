<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

namespace Sample_Mjmz\Utils;
use Sample_Mjmz\Beans\BeanChatRoom;
use Sample_Mjmz\Utils\Common;

/**
 * Description of SqlManager
 *
 * @author Administrator
 */
class SqlManager {
    const SQL_NAME = 'xq_app';
    const TABLE_USER = 'user';
    const TABLE_USERINFO = 'user_info';
    const TABLE_CHATROOM = 'chat_room';
    const TABLE_ROOMRECORD = 'room_record';
    const TABLE_USER_REPORT = 'user_report';
    const TABLE_BLACK_USER = 'black_user';
    const TABLE_USER_FRIEND = 'user_friend';
    
    const SQL_SUCCESS_STR = 'sql_success';
    const SQL_SUCCESS = 200;


    const RESULT_ERRORCODE = 'errorCode';
    const RESULT_ERRORMSG = 'errorMsg';

    private static function _createResultError($errorCode,$errorMsg) {
        $result[SqlManager::RESULT_ERRORCODE] = $errorCode;
        $result[SqlManager::RESULT_ERRORMSG] = $errorMsg;
        return $result;
    }
    
    private static function _createResultSuccess($msg=NULL) {
        $result[SqlManager::RESULT_ERRORCODE] = SqlManager::SQL_SUCCESS;
        $result[SqlManager::RESULT_ERRORMSG] = is_null($msg)?SqlManager::SQL_SUCCESS_STR:$msg;
        return $result;
    }

    //put your code here
    /**
     * 添加用户
     * @param type $userInfo
     * @return type
     */
    public static function insertUser($userInfo) {
        $sql = M(SqlManager::TABLE_USER);
        $d['user_name'] = $userInfo['userName'];
        $d['password'] = $userInfo['password'];
        $d['create_time'] = date("Y-m-d G:i:s");
        if(SqlManager::checkUserExist(SqlManager::TABLE_USER,$d)) {
            return SqlManager::_createResultError(Common::ERROR_USER_REGIST_EXIST, 'user is already exist');
        }
        if(!$sql->add($d)) {
            return SqlManager::_createResultError(Common::ERROR_REGIST, 'insert user error');
        }
        return SqlManager::_createResultSuccess($sql->where("user_name='%s'",$d['user_name'])
                ->field(array('user_id','user_name'))->find());
    }
    
    public static function login($userInfo) {
        $d['user_name'] = $userInfo['userName'];
        $d['password'] = $userInfo['password'];
        $sql = M(SqlManager::TABLE_USER);
        //检测是否存在该用户
        if(!SqlManager::checkUserExist(SqlManager::TABLE_USER,$d)) {
            return SqlManager::_createResultError(Common::ERROR_USER_NOT_EXIST
                    , 'the user is not exist');
        }
        $result = $sql->where("user_name='%s'",$d['user_name'])->find();
        if($d['password'] == $result['password']) {
            return SqlManager::_createResultSuccess(SqlManager::getUserInfoBySql($d));
        }
        return SqlManager::_createResultError(Common::ERROR_USER_PASSWORD_WRONG
                , 'password is wrong');
    }

    public static function checkUserExist($tableName,$userInfo) {
        $d['user_name'] = $userInfo['user_name'];
        if(is_null($d['user_name'])) {
            $d['user_name'] = $userInfo['userName'];
        }
        $sql = M($tableName);
        $result = $sql->where("user_name='%s'",$d['user_name'])->select();
        if(empty($result)) {
            return false;
        }
        return $result[0];
    }
    
    public static function updateUserInfo($userInfo) {
        $ex['user_name'] =$userInfo['userName'] ;
        if(isset($userInfo['nickName'])) {
            $ex['nick_name'] = $userInfo['nickName'];
        }
        $fianlArray = $userInfo + $ex;    
        $sql = M(SqlManager::TABLE_USERINFO);
        //检测是否存在该用户
        $result = SqlManager::checkUserExist(SqlManager::TABLE_USER,$fianlArray);
        if(!$result) {
            return SqlManager::_createResultError(Common::ERROR_USER_NOT_EXIST
                    , 'the user is not exist');
        }
        $fianlArray['user_id'] = $result['user_id'];
        //进行更新或者插入
        if(empty($sql->where("user_name='%s'",$fianlArray['user_name'])->select())) {
            $fianlArray['create_time'] = date("Y-m-d G:i:s");
            $sql->add($fianlArray);
        }else {
            $fianlArray['modify_time'] = date("Y-m-d G:i:s");
            $sql->where("user_name='%s'",$fianlArray['user_name'])->save($fianlArray);
        }
        //获取用户信息
        $sqlInfo = SqlManager::getUserInfoBySql($fianlArray);
        return SqlManager::_createResultSuccess($sqlInfo);
    }

    public static function uploadFile($userInfo)
    {
        $d['user_name'] = $userInfo['userName'];
        if(!SqlManager::checkUserExist(SqlManager::TABLE_USER, $d)) {
            return SqlManager::_createResultError(Common::ERROR_USER_NOT_EXIST
                    , 'the user is not exist'); 
        }
            
        $base_path = "/upload/XQ/"; //存放目录  
        if(!is_dir($base_path)){  
            mkdir($base_path,0777,true);  
        }  
        $target_path = $base_path.basename($_FILES['uploadFile'] ['name'] );  
        if (move_uploaded_file($_FILES['uploadFile']['tmp_name'],'.'.$target_path )) {  
//            $d['head_image'] = 'http://'.$_SERVER['SERVER_NAME'].'/thinkphp'.$target_path;
            $d['head_image'] = '/thinkphp'.$target_path;
            return SqlManager::updateUserInfo($d);
        } else {  
            return SqlManager::_createResultError(Common::ERROR_USER_UPLOAD
                    , "There was an error uploading the file, please try again!" . $_FILES ['attach'] ['error']); 
        }  
    }
    
    public static function getUserInfoBySql($userInfo) {
        $user_name = isset($userInfo['user_name'])?$userInfo['user_name']:$userInfo['userName'];
        $sql = M(SqlManager::TABLE_USERINFO);   
        $sqlInfo = $sql->where("user_name='%s'",$user_name)
                ->field('id',true)->find();
        $sqlInfo['head_image'] = 'http://'.$_SERVER['SERVER_NAME'].$sqlInfo['head_image'];
        return $sqlInfo;
    }
    
    /**
     * 添加或者更新
     * type  1:添加  2：更新   3:删除
     * @param BeanChatRoom $info
     */
    public static function updateChatRoom(array $info,int $type) {
        $sql = M(SqlManager::TABLE_CHATROOM);
        switch ($type) {
            case 1:
                //添加
                $sql->add($info);
                break;
            
            case 2:
                //更新
                $sql->where("id='%d'",$info['id'])->save($info);  
                break;
            
            case 3:
                //删除
                $sql->where("id='%d'",$info['id'])->delete();  
                break;

            default:
                break;
        }
    }
    
    /**
     * 获取chatRoomById
     * type 
     * @param BeanChatRoom $info
     */
    public static function getChatRoomById($id) {
        $sql = M(SqlManager::TABLE_CHATROOM); 
        $result = $sql->where("room_id='%s'",$id)->find();
        return $result;
    }
    
     /**
     * 添加或者更新
     * type  1:添加  2：更新   3:删除
     * @param BeanChatRoom $info
     */
    public static function updateRoomRecord(array $info,int $type) {
        $sql = M(SqlManager::TABLE_ROOMRECORD); 
        switch ($type) {
            case 1:
                //添加
                $result = SqlManager::getRoomRecordById($info['user_name'],$info['room_id']);
                if($result) {
                    SqlManager::updateRoomRecord($info, 2);
                }else {
                    $sql->add($info);
                }               
                break;
            
            case 2:
                //更新
                $sql->where("user_name='%s' and room_id='%s'",$info['user_name'],$info['room_id'])->save($info);  
                break;
            
            case 3:
                //删除
                $sql->where("user_name='%s' and room_id='%s'",$info['user_name'],$info['room_id'])->delete();  
                break;

            default:
                break;
        }
    }
    
    /**
     * RoomRecordById
     * type 
     * @param BeanChatRoom $info
     */
    public static function getRoomRecordById($userName,$roomId) {
        $sql = M(SqlManager::TABLE_ROOMRECORD); 
        $result = $sql->where("user_name='%s' and room_id='%s'",$userName,$roomId)->find();
        return $result;
    }
    
    /**
     * 举报用户
     * @return type
     */
    public static function reportUser($sqlData) {
        $sql = M(SqlManager::TABLE_USER_REPORT);
        $returnReslut = $sql->add($sqlData);
        $sqlReslult = $sql->where("room_id='%d'",$sqlData['room_id'])->select();
        $count = count($sqlReslult);
        $banTime = 0;
        $reports = array();
        if($count >= 3) {
            $reportMsg = '';
            for($index = 0 ; $index < $count ; $index++) {
                $reportType = $sqlReslult[$index]['report_type'];
                if(is_null($reports[$reportType])) {
                    $reportMsg .= Common::REPORT_ITEMS[$reportType-1].';';
                }
                $banTime += $reportType*1/3;
                $reports[$reportType] = '1';
            }
            $banTime *= Common::BLACK_BAN_BASE_TIME;
            $data['user_name'] = $sqlData['user_name'];
            $data['report_msg'] = $reportMsg;
            $data['room_id'] = $sqlData['room_id'];      
            $data['start_time'] = time();
            $strTime = '+'.$banTime.' hours';
            $data['end_time'] = strtotime($strTime);
           
            SqlManager::addBlackUser($data,1);
        }
        return $returnReslut;
    }
    
    /**
     * 举报用户
     * @return type
     */
    private static function addBlackUser($sqlData,$type) {
        $sql = M(SqlManager::TABLE_BLACK_USER);
        switch ($type) {
            case 1:
                //添加
                $sqlResult = $sql->where("user_name='%s' and room_id='%d'"
                            ,$sqlData['user_name'],$sqlData['room_id'])->select();
                if(count($sqlResult) > 0) {
                    SqlManager::addBlackUser($sqlData, 2);
                    return;
                }
                $sql->add($sqlData);
                break;
            
            case 2:
                //更新
                $sql->where("user_name='%s' and room_id='%d'"
                            ,$sqlData['user_name'],$sqlData['room_id'])->save($sqlData);
                break;

            default:
                break;
        }
    }
    
    /**
     * 获取用户名是否被禁
     * @param type $sqlData
     */
    public static function getBlackUserByName($sqlData) {
        $sql = M(SqlManager::TABLE_BLACK_USER);
        $sqlReslult = $sql->where("user_name='%s' and status='%d'",$sqlData['userName'],$sqlData['status'])->select();
        foreach ($sqlReslult as $value) {
            if($value['status'] == 1) {
                if(time() >= $value['end_time']) {
                    $value['status'] = 0;
                    SqlManager::addBlackUser($value, 2);
                }
            }
        }
        
        $sqlReslult = $sql->where("user_name='%s' and status='%d'",$sqlData['userName'],$sqlData['status'])
                ->order('end_time desc')->field('id', true)->select();
        return $sqlReslult[0];
    }
    
    /**
     * 添加好友
     * @param type $sqlData
     */
    public static function addFriend($sqlData) {
        $sql = M(SqlManager::TABLE_USER_FRIEND);
        $sqlData['time'] = date("Y-m-d G:i:s");
        $sqlResult = $sql->where("userName='%s' and targetName='%s'",$sqlData['userName'],$sqlData['targetName'])->select();
        if(count($sqlResult) == 0) {
            return $sql->add($sqlData);
        }
        return TRUE;
    }
    
     /**
     * 获取用户信息
     * @param type $sqlData
     */
    public static function getUserInfo($sqlData) {
        $sql = M(SqlManager::TABLE_USERINFO);
        $sqlResult = $sql->where("user_name='%s'",$sqlData['user_name'])->select();
        $sqlResult[0]['head_image'] ='http://'.$_SERVER['SERVER_NAME'].$sqlResult[0]['head_image'];
        return $sqlResult[0];
    }
    
     /**
     * 获取用户好友列表
     * @param type $sqlData
     */
    public static function getFriendListByUser($sqlData) {
        $sql = M(SqlManager::TABLE_USER_FRIEND);
        $sqlResult = $sql->where("userName='%s'",$sqlData['userName'])->select();
        $count = count($sqlResult);
        if($count == 0) {
            return FALSE;
        }
        
        $friendList = array();
        for($i = 0 ;$i < $count ; $i++) {
            $param['user_name'] = $sqlResult[$i]['targetName'];
            $info = SqlManager::getUserInfo($param);
            $friendList[] = $info;
        }
        return $friendList;
    }
}
