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
    const TABLE_PAY_ITEM = 'pay_item';
    const TABLE_PAY_ORDER = 'pay_order';
    const TABLE_GIFT_ITEM = 'gift_item';
    const TABLE_GIFT_CATEGORY = 'gift_category';
    const TABLE_GIFT_USER = 'gift_user';
    const TABLE_COIN_CONSUME_HISTORY = 'coin_consume_history';
    const TABLE_GIFT_EXPIRY = 'gift_expiry';
    
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

    /**
     * 获取充值项目
     * @return mixed
     */
    public static function getPayItem() {
        $sql = M(SqlManager::TABLE_PAY_ITEM);
        $sqlResult = $sql->order("sort asc")->select();
        return $sqlResult;
    }

    /**
     * 创建支付订单
     * @return mixed
     */
    public static function makePayOrder($sqlData) {
        $sql = M(SqlManager::TABLE_PAY_ORDER);
        $sqlResult = $sql->add($sqlData);
        return $sqlResult;
    }

    /**
     * 支付回调
     * @return mixed
     */
    public static function handlePayCallback($sqlData) {
        $sql = M(SqlManager::TABLE_PAY_ORDER);
        $sqlResult = $sql->where("order_id='%s'",$sqlData['order_id'])->find();
        if($sqlResult['status'] != 0) {
            return -2;
        }
        $result = $sql->where("order_id='%s'",$sqlData['order_id'])->save($sqlData);
        if($result) {
            $sqlResult = $sql->where("order_id='%s'",$sqlData['order_id'])->find();
            $user_name = $sqlResult['user_name'];
            $sqlUser = M(SqlManager::TABLE_USERINFO);
            $result = $sqlUser->where("user_name='%s'",$user_name)->setInc('balance',$sqlResult['coin']);
            if($result) {
                $userInfo = $sqlUser->where("user_name='%s'",$user_name)->find();
                return array('balance'=>$userInfo['balance'],'coin'=>$sqlResult['coin'],
                    'modify_time'=>$sqlResult['modify_time'],
                    'userInfo'=>$userInfo);
            }
        }

        return -1;
    }

    /**
     * 获取充值列表
     * @return mixed
     */
    public static function getPayHistory($sqlData) {
        $sql = M(SqlManager::TABLE_PAY_ORDER);
        $sqlResult = $sql->where("user_name='%s' and status='%s'",$sqlData['user_name'],$sqlData['status'])
            ->field('id,user_name',true)->order('modify_time desc')->select();
        return $sqlResult;
    }

    /**
     * 获取礼品项目
     * @return mixed
     */
    public static function getGiftItem($position) {
        $querySql = sprintf("SELECT a.gift_id,a.is_trade,b.`name`,b.coin,b.image,
            b.description,b.gif FROM xq_gift_category a,xq_gift_item b WHERE a.gift_id = b.gift_id 
            and a.position = '%d' ORDER BY sort",
            $position);
        $sqlResult = M()->query($querySql);
        for($i = 0 ; $i < count($sqlResult) ; $i ++) {
            $sqlResult[$i]['image'] = 'http://'.$_SERVER['SERVER_NAME'].$sqlResult[$i]['image'];
            $sqlResult[$i]['gif'] = 'http://'.$_SERVER['SERVER_NAME'].$sqlResult[$i]['gif'];
        }
        return $sqlResult;
    }

    /**
     * 用钻石购买礼物
     * @return mixed
     */
    public static function buyGiftByCoin($sqlData) {
        $sql = M(SqlManager::TABLE_COIN_CONSUME_HISTORY);
        $sqlResult = $sql->add($sqlData);
        if(!$sqlResult) return $sqlResult;
        $sqlUser = M(SqlManager::TABLE_USERINFO);
        $sqlResult = $sqlUser->where("user_name='%s'",$sqlData['user_name'])->setDec('balance',$sqlData['coin']);
        if(!$sqlResult) return $sqlResult;
        $sql = M(SqlManager::TABLE_GIFT_USER);
        $sqlResult = $sql->add($sqlData);
        $userInfo = $sqlUser->where("user_name='%s'",$sqlData['user_name'])->find();
        return $userInfo['balance'];
    }

    /**
     * 获取自己礼物列表
     * @return mixed
     */
    public static function getGiftList($sqlData) {
        $querySql = sprintf("SELECT a.gift_id,b.type,b.coin,b.description,b.image,
              b.`name`,COUNT(a.gift_id) AS num FROM xq_gift_user AS a,
              xq_gift_item AS b WHERE a.gift_id = b.gift_id and 
              a.user_name='%s' and a.to_user='%s' GROUP BY a.gift_id ORDER BY num DESC",
                  $sqlData['user_name'],$sqlData['user_name']);
        $sqlResult = M()->query($querySql);
        for($i = 0 ; $i < count($sqlResult) ; $i ++) {
            $sqlResult[$i]['image'] = 'http://'.$_SERVER['SERVER_NAME'].$sqlResult[$i]['image'];
        }
        return $sqlResult;
    }

    /**
     * 获取消费记录
     * @return mixed
     */
    public static function getConsumeHistory($sqlData) {
        $querySql = sprintf("SELECT a.gift_id,a.to_user,b.type,b.coin,b.`name`,b.image,c.nick_name,
            c.head_image,a.create_time FROM xq_gift_user AS a,xq_gift_item AS b,
            xq_user_info AS c WHERE a.gift_id = b.gift_id and a.user_name='%s' 
            and a.to_user=c.user_name ORDER BY a.create_time DESC",
            $sqlData['user_name']);
        $sqlResult = M()->query($querySql);
        $convertResult = [];
        foreach ($sqlResult as $value) {
            if(count($convertResult) == 0) {
                $value['num'] = 1;
                array_push($convertResult,$value);
            }else {
                $temp = $convertResult[count($convertResult)-1];
                if(($value['gift_id'] == $temp['gift_id'])
                    && abs($temp['create_time']-$value['create_time']) < 8) {
                    //8秒内的算一个组
                    $temp['num'] ++;
                    $convertResult[count($convertResult)-1] = $temp;
                }else {
                    //不是同类的
                    $value['num'] = 1;
                    array_push($convertResult,$value);
                }
            }
        }

        for($i = 0 ; $i < count($convertResult) ; $i ++) {
            $convertResult[$i]['image'] = 'http://'.$_SERVER['SERVER_NAME'].$convertResult[$i]['image'];
            $convertResult[$i]['head_image'] = 'http://'.$_SERVER['SERVER_NAME'].$convertResult[$i]['head_image'];
        }
        return $convertResult;
    }

    /**
     * 消费礼物
     * @return mixed
     */
    public static function consumeGift($sqlData) {
        $sqlUser = M(SqlManager::TABLE_USERINFO);
        $sqlGiftUser = M(SqlManager::TABLE_GIFT_USER);
        $giftList = [];
        if($sqlData['handleType'] == 1) {
            //直接金币消费
            $sqlResult = $sqlUser->where("user_name='%s'",$sqlData['user_name'])->setDec('balance',$sqlData['coin']);
            if(!$sqlResult) return $sqlResult;
            //存入到金币消费记录中
            $sql = M(SqlManager::TABLE_COIN_CONSUME_HISTORY);
            $sqlResult = $sql->add($sqlData);
            //记录到我的礼物中
            $sqlResult = $sqlGiftUser->add($sqlData);
            //给用户添加金币
            $sqlResult = $sqlUser->where("user_name='%s'",$sqlData['to_user'])->setInc('balance',$sqlData['coin']);
        }else if($sqlData['handleType'] == 2){
            //从我的包裹中消费,删除一条
            $sqlResult = $sqlGiftUser->where("user_name='%s' and gift_id='%d' and to_user='%s'",
                $sqlData['user_name'],$sqlData['gift_id'],$sqlData['user_name'])->limit(1)->delete();
            //存入到金币消费记录中
            $sqlResult = $sqlGiftUser->add($sqlData);
            if($sqlResult == 0) return $sqlResult;
            //给用户添加金币
            $sqlResult = $sqlUser->where("user_name='%s'",$sqlData['to_user'])->setInc('balance',$sqlData['coin']);
            //获取自己的礼物列表
            $giftList = SqlManager::getGiftList($sqlData);
        }

        $userInfo = $sqlResult = $sqlUser->where("user_name='%s'",$sqlData['user_name'])->find();
        $data['balance'] = $userInfo['balance']; //余额
        $data['gift_list'] = $giftList; //礼物列表
        return $data;
    }

    /**
     *
     * 创房间的时候检测是否免费的卡
     */
    public static function checkRoomExpiry($sqlData) {
        $coin = 0;
        $sqlResult = [];
        $gift = [];
        if($sqlData['handleType'] == 1) {
            //创建房间
            //建房卡
            $sqlResult = M(SqlManager::TABLE_GIFT_EXPIRY)->field("id",true)
                ->where("gift_id=6 and end_time<'%d' and user_name='%s'",time(),$sqlData['user_name'])
                ->select();
            $coin = M(SqlManager::TABLE_GIFT_ITEM)->where("gift_id=1000")->find()['coin'];
            $gift = M()->query(sprintf("SELECT COUNT(a.gift_id) AS num,b.gift_id,b.`name`,
                b.description FROM xq_gift_user a,xq_gift_item b WHERE 
                a.user_name='%s' AND a.to_user='%s' AND 
                a.gift_id=6 AND a.gift_id = b.gift_id GROUP BY a.gift_id",
                $sqlResult['user_name'],
                $sqlResult['user_name']));
        }else if($sqlData['handleType'] == 2) {
            //加入房间
            //入门券
            $sqlResult = M(SqlManager::TABLE_GIFT_EXPIRY)->where("gift_id=4 and num>0 and user_name='%s'",$sqlData['user_name'])
                ->field("id",true)->select();
            $gift = M()->query(sprintf("SELECT COUNT(a.gift_id) AS num,b.gift_id,b.`name`,
                b.description FROM xq_gift_user a,xq_gift_item b WHERE 
                a.user_name='%s' AND a.to_user='%s' AND 
                a.gift_id=4 AND a.gift_id = b.gift_id GROUP BY a.gift_id",
                $sqlResult['user_name'],
                $sqlResult['user_name']));
            $coin = M(SqlManager::TABLE_GIFT_ITEM)->where("gift_id=1001")->find()['coin'];
        }

        $result['expiry'] = $sqlResult;
        $result['coin'] = $coin;
        $result['gift'] = $gift;
        return $result;
    }
}
