<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

namespace Sample_Mjmz\Utils;
use Sample_Mjmz\Beans\BeanChatRoom;
use Sample_Mjmz\Utils\Common;
use JPush;

/**
 * Description of SqlManager
 *
 * @author Administrator
 */
class SqlManager {
    const SQL_NAME = 'xq_app';
    const TABLE_APP_SETTINGS = 'app_settings';
    const TABLE_USER = 'user';
    const TABLE_USERINFO = 'user_info';
    const TABLE_CHAT = 'chat';
    const TABLE_CHAT_ROOM = 'chat_room';
    const TABLE_CHAT_ROOM_USER = 'chat_room_user';
    const TABLE_CHAT_USER = 'chat_user';
    const TABLE_USER_REPORT = 'user_report';
    const TABLE_BLACK_USER = 'black_user';
    const TABLE_USER_FRIEND = 'user_friend';
    const TABLE_PAY_ITEM = 'pay_item';
    const TABLE_PAY_ORDER = 'pay_order';
    const TABLE_GIFT_ITEM = 'gift_item';
    const TABLE_GIFT_CATEGORY = 'gift_category';
    const TABLE_GIFT_USER = 'gift_user';
    const TABLE_COIN_CONSUME_HISTORY = 'coin_consume_history';
    const TABLE_VERSION = 'version';
    const TABLE_BANNER = 'banner';
    const TABLE_BONUS_ITEM = 'bonus_item';
    const TABLE_BONUS_USER = 'bonus_user';
    
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
        $Model = M();
        $Model->startTrans();
        try{
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
                $fianlArray['create_time'] = ToolUtil::getCurrentTime();
                $sql->add($fianlArray);
            }else {
                $fianlArray['modify_time'] = ToolUtil::getCurrentTime();
                $sql->where("user_name='%s'",$fianlArray['user_name'])->save($fianlArray);
            }
            //添加注册的优惠
            if($fianlArray['handleType'] == 1) {
                //注册过来的
                $tableBonusUser = M(SqlManager::TABLE_BONUS_USER);
                $bonusData['user_name'] = $fianlArray['user_name'];
                $bonusData['create_time'] = ToolUtil::getCurrentTime();
                $bonusData['bonus_id'] = Common::BONUS_ID_REGISTER;  //注册事件
                if($userInfo['role_type'] == Common::ROLRTYPE_ANGEL) {
                    //爱心大使
                    $bonusData['gift_id'] = 8; //长期建房卡
                    $bonusData['num'] = 1;
                    $tableBonusUser->add($bonusData);

                    $bonusData['gift_id'] = 6; //临时建房卡
                    $bonusData['num'] = 5;
                    $tableBonusUser->add($bonusData);
                }else if($userInfo['role_type'] == Common::ROLETYPE_AUDIENCE) {
                    //观众

                }else if($userInfo['role_type'] == Common::ROLETYPE_GUEST) {
                    //嘉宾
                    if($userInfo['gender'] == Common::MAN) {
                        //男
                        $bonusData['gift_id'] = 4; //券
                        $bonusData['num'] = 1;
                        $tableBonusUser->add($bonusData);

                        $bonusData['gift_id'] = 7; //延时卡
                        $bonusData['num'] = 2;
                        $tableBonusUser->add($bonusData);
                    }else if($userInfo['gender'] == Common::LADY) {
                        //女
                        $bonusData['gift_id'] = 7; //延时卡
                        $bonusData['num'] = 2;
                        $tableBonusUser->add($bonusData);
                    }
                }
            }

            $Model->commit();
        }catch (\Exception $e) {
            $Model->rollback();
            return false;
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
                ->field('id,real_name,id_card',true)->find();
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
        $sqlReslult = $sql->where("room_id='%d' and inner_id='%s'",$sqlData['room_id'],$sqlData['inner_id'])->select();
        $count = count($sqlReslult);
        $banTime = 0;
        $reports = array();
        if($count >= Common::REPORT_VALID_COUNT) {
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
            $data['start_time'] = ToolUtil::getCurrentTime();
            $strTime = '+'.$banTime.' hours';
            $data['end_time'] = ToolUtil::getTimeStrByTime(strtotime($strTime));
           
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
     * @return
     */
    public static function getBlackUserByName($sqlData) {
        $sql = M(SqlManager::TABLE_BLACK_USER);
        $sqlReslult = $sql->where("user_name='%s' and status='%d'",$sqlData['userName'],$sqlData['status'])->select();
        foreach ($sqlReslult as $value) {
            if($value['status'] == 1) {
                if(time() >= strtotime($value['end_time'])) {
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
     * @return
     */
    public static function getUserInfo($sqlData) {
        $sql = M(SqlManager::TABLE_USERINFO);
        $sqlResult = $sql->where("user_name='%s'",$sqlData['user_name'])->select();
        if(count($sqlResult) > 0) {
            $sqlResult[0]['head_image'] ='http://'.$_SERVER['SERVER_NAME'].$sqlResult[0]['head_image'];
        }else {
            return false;
        }
        return $sqlResult[0];
    }

    /**
     * 获取用户好友列表
     * @param type $sqlData
     * @return mixed
     */
    public static function getFriendListByUser($sqlData) {
        $sqlStr = sprintf("SELECT b.* FROM xq_user_friend a,xq_user_info b WHERE 
              a.userName='%s' AND a.targetName = b.user_name",$sqlData['userName']);
        $sqlResult = M()->query($sqlStr);
        return $sqlResult;
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
            LogUtil::writePayCallbackLog('订单已经处理');
            return -1;
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

        LogUtil::writePayCallbackLog('订单处理失败');
        return -2;
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
        $result = [];

        $sqlUser = M(SqlManager::TABLE_USERINFO);
        $userInfo = $sqlUser->where("user_name='%s'",$sqlData['user_name'])->find();
        if($userInfo['balance'] - $sqlData['coin'] < 0) {
            //金币不够
            $result['code'] = Common::ERROR_LACK_STOCK;
            $result['data'] = $userInfo['balance'];
        }else {
            $sql = M(SqlManager::TABLE_COIN_CONSUME_HISTORY);
            $sqlResult = $sql->add($sqlData);
            if(!$sqlResult) return $sqlResult;
            $sqlResult = $sqlUser->where("user_name='%s'",$sqlData['user_name'])->setDec('balance',$sqlData['coin']);
            if(!$sqlResult) return $sqlResult;
            $sql = M(SqlManager::TABLE_GIFT_USER);
            $sqlResult = $sql->where("user_name='%s' and gift_id='%d' and status=0",
                $sqlData['user_name'],$sqlData['gift_id'])->find();
            if($sqlResult) {
                $sqlResult = $sql->where("user_name='%s' and gift_id='%d' and status=0",$sqlData['user_name'],$sqlData['gift_id'])
                    ->setInc('num',1);
            }else {
                $sqlData['num'] = 1;
                $sqlResult = $sql->add($sqlData);
            }
            $userInfo = $sqlUser->where("user_name='%s'",$sqlData['user_name'])->find();
            $result['code'] = Common::SUCCESS;
            $result['data'] = $userInfo['balance'];
        }
        return $result;
    }

    /**
     * 获取自己礼物列表
     * @return mixed
     */
    public static function getGiftList($sqlData) {
        SqlManager::_checkExpiryDate();

        $querySql = sprintf("SELECT a.*,b.type,b.coin,b.`name`,b.image,b.gif,CONCAT(a.gift_id,a.status) 
                  AS _f FROM xq_gift_user a,xq_gift_item b WHERE a.user_name='%s' AND a.num > 0
                  AND a.gift_id = b.gift_id and a.status <> 2 GROUP BY _f ORDER BY a.num DESC",
                  $sqlData['user_name']);
        $sqlResult = M()->query($querySql);
        for($i = 0 ; $i < count($sqlResult) ; $i ++) {
            $sqlResult[$i]['image'] = 'http://'.$_SERVER['SERVER_NAME'].$sqlResult[$i]['image'];
            $sqlResult[$i]['gif'] = 'http://'.$_SERVER['SERVER_NAME'].$sqlResult[$i]['gif'];
        }
        return $sqlResult;
    }

    /**
     * 获取消费记录
     * @return mixed
     */
    public static function getConsumeHistory($sqlData) {
        $querySql = sprintf("SELECT a.gift_id,a.user_name,a.to_user,b.type,b.coin,b.`name`,
            b.image,c.nick_name,c.head_image,a.create_time FROM 
            xq_coin_consume_history a,xq_gift_item b,xq_user_info c WHERE a.user_name ='%s' 
            AND a.gift_id = b.gift_id AND a.to_user = c.user_name ORDER BY create_time DESC",
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
                    && $value['to_user'] == $temp['to_user']
                    && abs(strtotime($temp['create_time'])-strtotime($value['create_time'])) < 10) {
                    //10秒内的算一个组
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
     * private 消费礼品
     * @param $sqlData
     * @return false
     */
    private static function _consumeGift($sqlData) {
        $sqlUser = M(SqlManager::TABLE_USERINFO);
        $sqlGiftUser = M(SqlManager::TABLE_GIFT_USER);
        $sqlConsume = M(SqlManager::TABLE_COIN_CONSUME_HISTORY);
        $giftList = [];
        if($sqlData['handleType'] == 1) {
            //直接金币消费
            $sqlResult = $sqlUser->where("user_name='%s'",$sqlData['user_name'])->setDec('balance',$sqlData['coin']);
            if(!$sqlResult) return $sqlResult;
            //添加到消费列表中
            $sqlResult = $sqlConsume->add($sqlData);
            if(!$sqlResult) return $sqlResult;
            //给用户添加金币
            $sqlResult = $sqlUser->where("user_name='%s'",$sqlData['to_user'])->setInc('balance',$sqlData['coin']);
            //返回
            return $giftList;
        }else if($sqlData['handleType'] == 2) {
            //包裹消费
            $sqlResult = $sqlGiftUser->where("user_name='%s' and gift_id='%d' and status='%d'",
                $sqlData['user_name'],$sqlData['gift_id'],0)->setDec('num',1);
            if(!$sqlResult) return $sqlResult;
            //给用户添加金币
            $sqlResult = $sqlUser->where("user_name='%s'",$sqlData['to_user'])->setInc('balance',$sqlData['coin']);
            if(!$sqlResult) return $sqlResult;
            //获取自己的礼物列表
            $giftList = SqlManager::getGiftList($sqlData);

            //返回
            return $giftList;
        }
        return false;
    }

    private static function _addConsumeCard($sqlData) {
        $sql = M(SqlManager::TABLE_GIFT_ITEM);
        $sqlGiftUser = M(SqlManager::TABLE_GIFT_USER);
        $giftInfo = $sql->where("gift_id='%d'",$sqlData['gift_id'])->find();

        $insert['gift_id'] = $sqlData['gift_id'];
        $insert['user_name'] = $sqlData['user_name'];
        $insert['num'] = 1;
        if($giftInfo['gift_id'] == 4 && $giftInfo['type'] == 2) {
            //入门券
            $insert['expiry_num'] = $giftInfo['value'];
        }else if($giftInfo['gift_id'] == 6 && $giftInfo['type'] == 2) {
            //建房卡
            $insert['start_time'] = ToolUtil::getCurrentTime();
            $endTime = ToolUtil::getTimeStrByTime(strtotime($insert['start_time'])
                + $giftInfo['value']*60*60);  //一小时计算
            $insert['end_time'] = $endTime;
        }
        $insert['status'] = 1; //使用中
        $sqlResult = $sqlGiftUser->add($insert);

        return $sqlResult;
    }

    /**
     * private 消费卡券
     * @param $sqlData
     * @return false
     */
    private static function _consumeCard($sqlData) {
        $sqlUser = M(SqlManager::TABLE_USERINFO);
        $sqlGiftUser = M(SqlManager::TABLE_GIFT_USER);
        $sqlConsume = M(SqlManager::TABLE_COIN_CONSUME_HISTORY);
        $giftList = [];
        if($sqlData['handleType'] == 1) {
            //直接金币消费
            $sqlResult = $sqlUser->where("user_name='%s'",$sqlData['user_name'])->setDec('balance',$sqlData['coin']);
            if(!$sqlResult) return $sqlResult;
            //添加到消费列表中
            $sqlResult = $sqlConsume->add($sqlData);
            if(!$sqlResult) return $sqlResult;
            //添加到我的礼品表中
            $sqlResult = SqlManager::_addConsumeCard($sqlData);
            if(!$sqlResult) return $sqlResult;

            //返回
            return $giftList;
        }else if($sqlData['handleType'] == 2) {
            //包裹消费
            $sqlResult = $sqlGiftUser->where("user_name='%s' and gift_id='%d' and status='%d'",
                $sqlData['user_name'],$sqlData['gift_id'],0)->setDec('num',1);
            if(!$sqlResult) return $sqlResult;
            //添加到我的礼品表中
            $sqlResult = SqlManager::_addConsumeCard($sqlData);
            if(!$sqlResult) return $sqlResult;
            //获取自己的礼物列表
            $giftList = SqlManager::getGiftList($sqlData);

            //返回
            return $giftList;
        }
        return false;
    }

    /**
     * private 消费固定消费
     * @param $sqlData
     * @return false
     */
    private static function _consumeFix($sqlData) {
        $sqlUser = M(SqlManager::TABLE_USERINFO);
        $sqlConsume = M(SqlManager::TABLE_COIN_CONSUME_HISTORY);
        $giftList = [];
        if($sqlData['handleType'] == 1) {
            //直接金币消费
            $sqlResult = $sqlUser->where("user_name='%s'",$sqlData['user_name'])->setDec('balance',$sqlData['coin']);
            if(!$sqlResult) return $sqlResult;
            //添加到消费列表中
            $sqlResult = $sqlConsume->add($sqlData);
            if(!$sqlResult) return $sqlResult;

            return $giftList;
        }

        return false;
    }

    /**
     * 消费礼物
     * @return mixed
     */
    public static function consumeGift($sqlData) {
        $giftList = [];
        $sql = M(SqlManager::TABLE_GIFT_ITEM);
        $giftInfo = $sql->where("gift_id='%d'",$sqlData['gift_id'])->find();
        $userInfo = M(SqlManager::TABLE_USERINFO)->where("user_name='%s'",$sqlData['user_name'])->find();
        if($sqlData['handleType'] == 1 && ($userInfo['balance'] - $sqlData['coin'] < 0)) {
            $result['code'] = Common::ERROR_LACK_STOCK;
            $result['data']['balance'] = $userInfo['balance'];
            $result['data']['gift_list'] = []; //礼物列表
            return $result;
        }

        if($giftInfo['type'] == 1) {
            //礼品
            $giftList = SqlManager::_consumeGift($sqlData);
        }else if($giftInfo['type'] == 2) {
            //卡
            $giftList = SqlManager::_consumeCard($sqlData);
        }else if($giftInfo['type'] == 100) {
            //固定消费
            $giftList = SqlManager::_consumeFix($sqlData);
        }

        $userInfo = $sqlResult = M(SqlManager::TABLE_USERINFO)->where("user_name='%s'",$sqlData['user_name'])->find();
        $data['balance'] = $userInfo['balance']; //余额
        $data['gift_list'] = $giftList; //礼物列表

        $result['code'] = Common::SUCCESS;
        $result['data'] = $data;
        return $result;
    }

    /**
     * 创建或者进入房间的时候检测是否免费的卡
     */
    public static function checkRoomExpiry($sqlData) {
        SqlManager::_checkExpiryDate();

        $coin = [];
        $sqlResult = [];
        $gift = [];
        $hasCard = 0;
        $gift_id = 0;
        $fix_id = 0;
        if($sqlData['handleType'] == 1) {
            //创建房间
            //建房卡
            $gift_id = 6;
            $fix_id = 1000;
        }else if($sqlData['handleType'] == 2) {
            //加入房间
            //入门券
            $gift_id = 4;
            $fix_id = 1001;
        }else {
            return false;
        }
        $sqlResult = M()->query(sprintf("SELECT a.gift_id,a.expiry_num,a.start_time,a.end_time,
                              b.coin,b.`name`,b.description,b.`value` FROM xq_gift_user a,xq_gift_item b 
                              WHERE a.gift_id='%d' AND a.`status`=1 AND a.gift_id = b.gift_id AND a.user_name='%s'",
            $gift_id,$sqlData['user_name']));
        $coin = M(SqlManager::TABLE_GIFT_ITEM)->where("gift_id='%d'",$fix_id)->find();
        $gift = M()->query(sprintf("SELECT a.gift_id,b.coin,b.`name`,b.description,
                              b.`value` FROM xq_gift_user a,xq_gift_item b WHERE a.gift_id='%d' AND a.`status`=0 
                              AND a.gift_id = b.gift_id AND a.user_name='%s' AND a.num > 0",
            $gift_id,$sqlData['user_name']));
        if(count($gift) > 0) {
            $hasCard = 1;
        }else {
            $hasCard = 0;
            $gift = M(SqlManager::TABLE_GIFT_ITEM)->where("gift_id='%d'",$gift_id)
                ->field("coin,name,description,value")->select();
        }
        if($sqlData['handleType'] == 2 && count($sqlResult) > 0) {
            //加入房间，则expiry_num减一
            M(SqlManager::TABLE_GIFT_USER)->where("user_name='%s' and gift_id='%d' and status=1"
                ,$sqlData['user_name'],$gift_id)->setDec("expiry_num",1);
            $sqlResult[0]['expiry_num'] -= 1;
        }

        $result['expiry'] = count($sqlResult)?$sqlResult[0]:null;
        $result['targetGift'] = $coin;
        $result['gift'] = count($gift)?$gift[0]:null;
        $result['hasCard'] = $hasCard;
        return $result;
    }

    /**检测并设置过期卡
     * @return false
     */
    private static function _checkExpiryDate() {
        $sqlStr = sprintf("UPDATE xq_gift_user SET `status`=2 WHERE `status`=1 
                        AND end_time is not  null AND end_time <= NOW()");
        $sqlResult = M()->execute($sqlStr);

        $sqlStr = sprintf("UPDATE xq_gift_user SET `status`=2 WHERE `status`=1 
                        AND expiry_num = 0");
        $sqlResult = M()->execute($sqlStr);
        return $sqlResult;
    }

    /**
     * 获取用户参与过的房间
     * @param $sqlData
     * @return false
     */
    public static function getChatRoomListByUser($sqlData) {
        $sqlStr = sprintf("SELECT a.inner_id,a.room_id,a.room_role_type,a.start_time,a.end_time,a.user_name,
            a.`status`,b.`status` as room_status,c.user_name as creater,c.title FROM xq_chat_room_user a,xq_chat_room b,
            xq_chat c WHERE a.user_name='%s' AND a.room_id=c.room_id ORDER BY a.start_time DESC",
            $sqlData['user_name']);
        $result = M()->query($sqlStr);
        return $result;
    }

    /**检查是否更新
     * @param $sqlData
     * @return false
     */
    public static function checkUpdate($sqlData) {
        $result = M(SqlManager::TABLE_VERSION)->where("version_code>'%d'",$sqlData['version_code'])->field("id",true)
            ->order("time DESC")->find();
        return $result;
    }

    /**获取Banner数据
     * @return false
     */
    public static function getBanner() {
        $result = M(SqlManager::TABLE_BANNER)->field("id",true)->order("sort")->select();
        return $result;
    }

    /**
     * 预约房间
     * @param $sqlData
     * @return false
     */
    public static function appointChatRoom($sqlData) {
        //添加到房间表中
        $newData = $sqlData;
        $newData['count_angel'] = 1;
        $newData['start_time'] = ToolUtil::getCurrentTime();
        $Model = M();
        $Model->startTrans();
        try{
            M(SqlManager::TABLE_CHAT)->add($newData);
            //添加到个人房间记录表中
            $info['room_id'] = $sqlData['room_id'];
            $info['user_name'] = $sqlData['user_name'];
            $info['start_time'] = $newData['start_time'];
            $info['room_role_type'] = 1;  //参与者
            M(SqlManager::TABLE_CHAT_USER)->add($info);

            $Model->commit();
        }catch (\Exception $e) {
            $Model->rollback();
            return false;
        }
        return true;
    }

    /**
     * 删除房间
     * @param $sqlData
     * @return false
     */
    public static function deleteChatRoom($sqlData) {
        $sqlData['status'] = 0;  //设置为失败
        return SqlManager::exitChatRoom($sqlData,true);
    }

    /**
     * 加入房间
     * @param $sqlData
     * @return false
     */
    public static function joinChatRoom($sqlData) {
        $userInfo['user_name'] = $sqlData['user_name'];
        $userInfo['start_time'] = ToolUtil::getCurrentTime();
        $userInfo['room_role_type'] = $sqlData['room_role_type'];  //身份

        $roomId = '';
        $limitStr = $sqlData['gender']==Common::MAN?'limit_man':'limit_lady';
        $countStr = $sqlData['gender']==Common::MAN?'count_man':'count_lady';
        if($sqlData['handleType'] == 1) {
            $sqlStr = sprintf("SELECT * FROM xq_chat where `work`<>2"); //还在没删除的
            $result = M()->query($sqlStr)[0];
            //匹配模式
            if(!$result) {
                //未找到则直接返回
                return -1; //未找到
            }
            //找到了则
            $roomId = $result['room_id'];
        }else if($sqlData['handleType'] == 2) {
            //指定房间号,并且未结束的
            $result = M(SqlManager::TABLE_CHAT)->where("room_id='%s' and work<>2",$sqlData['room_id'])->find();
            if($result) {
                //找到了
                $roomId = $result['room_id'];
            }else {
                return -1;//未找到
            }
        }

        $Model = M();
        $Model->startTrans();
        try{
            $isQueue = false;   //是否排队
            $sqlStr = sprintf("SELECT * FROM xq_chat where room_id='%s' and `work`<>2",$roomId); //还在没删除的
            $result = M()->query($sqlStr)[0];
            if($result[$countStr] >= $result[$limitStr]) {
                $isQueue = true;
            }
            if($userInfo['room_role_type'] == 1 && !$isQueue) {
                //参与者并且参与模式，而不是排队，且只有等待的房间
                M(SqlManager::TABLE_CHAT)->where("room_id='%s' and work=0",$roomId)->setInc($countStr,1); //人员数+1
            }
            //添加到个人房间记录中
            $userInfo['room_id'] = $roomId;
            M(SqlManager::TABLE_CHAT_USER)->add($userInfo);
            $Model->commit();
        }catch (\Exception $e) {
            $Model->rollback();
            return false;
        }
        //查找房间成员(参与者)
        $result = [];
        $roomInfo = M(SqlManager::TABLE_CHAT)->where("room_id='%s'",$userInfo['room_id'])->find();
        $data['room_id'] = $roomInfo['room_id'];
        $data['creater'] = $roomInfo['creater'];
        $data['appoint_time'] = $roomInfo['appoint_time'];
        $data['isPublic'] = $roomInfo['public'];
        $data['isQueue'] = $isQueue?2:1;
        $data['member'] = $result;
        return $data;
    }

    /**
     * 上报房间结果
     * @param $sqlData
     * @return bool
     */
    public static function commitChatRoomResult($sqlData) {
        //处理数据库
        $Model = M();
        $Model->startTrans();
        try{
            //更新xq_chat_user
            M(SqlManager::TABLE_CHAT)->where("room_id='%s'",$sqlData['room_id'])
                ->setField("work",0);
            //更新xq_chat_user
            M(SqlManager::TABLE_CHAT_USER)->where("room_id='%s' and work=1",$sqlData['room_id'])->setField('work',0);
            //更新xq_chat_room,标识为结束
            $newData['end_time'] = ToolUtil::getCurrentTime();
            $newData['status'] = $sqlData['status'];
            if($newData['status'] == 1) {
                //成功的话
                $newData['man_user'] = $sqlData['man_user'];
                $newData['lady_user'] = $sqlData['lady_user'];
            }
            M(SqlManager::TABLE_CHAT_ROOM)->where("room_id='%s' and inner_id='%s'",
                $sqlData['room_id'],$sqlData['inner_id'])
                ->save($newData);
            //更新xq_chat_room_user，填入结束日期
            M(SqlManager::TABLE_CHAT_ROOM_USER)->where("room_id='%s' and inner_id='%s'",
                $sqlData['room_id'],$sqlData['inner_id'])
                ->save($newData);

            $charInfo = M(SqlManager::TABLE_CHAT)->where("room_id='%s'",$sqlData['room_id'])->find();
            //给奖励
            $tableBonusUser = M(SqlManager::TABLE_BONUS_USER);
            $bonusData['user_name'] = $charInfo['user_name'];
            $bonusData['create_time'] = ToolUtil::getCurrentTime();
            $bonusData['bonus_id'] = Common::BONUS_ID_CHAT_SUCCESS;  //房间匹配成功
            if($newData['status'] == 1) {
                $sqlStr = sprintf("SELECT a.inner_id,b.user_name FROM xq_chat_room a,xq_chat b 
                  WHERE a.`status`=1 AND a.room_id=b.room_id");
                $roomArray = M()->query($sqlStr);
                $bonusData['num'] = 1;
                if(count($roomArray)%10 == 0 && count($roomArray) > 0) {
                    //累计10对
                    $bonusData['gift_id'] = 8; //长期建房卡
                    $tableBonusUser->add($bonusData);
                }else if(count($roomArray) > 0){
                    $bonusData['gift_id'] = 6; //临时建房卡
                    //判断当天是否获取过
                    $sqlStr = sprintf("SELECT * FROM xq_bonus_user WHERE TO_DAYS(create_time) = TO_DAYS(now())");
                    $result = M()->query($sqlStr);
                    if(count($result) == 0) {
                        //说明没有获取过
                        $tableBonusUser->add($bonusData);
                    }
                }
            }

            //给爱心大使加砖石,若此次被举报了则不奖励
            $report = M(SqlManager::TABLE_USER_REPORT)
                ->where("room_id='%d' and inner_id='%s'",$sqlData['room_id'],$sqlData['inner_id'])
                ->select();
            if(count($report) == 0) {
                //没被举报
                //获取男嘉宾进入房间所需的钻石
                $giftItem = M(SqlManager::TABLE_GIFT_ITEM)->where("gift_id=1001")->find();
                $num = $giftItem['coin']*$charInfo['count_man'];
                //房间记录奖励
                M(SqlManager::TABLE_CHAT_ROOM)->where("room_id='%s' and inner_id='%s'",
                    $sqlData['room_id'],$sqlData['inner_id'])
                    ->setInc('bonus',$num);
                //用户余额加入奖励
                M(SqlManager::TABLE_USERINFO)->where("user_name='%s'", $charInfo['user_name'])
                    ->setInc('balance',$num);
            }

            $Model->commit();
        }catch (\Exception $e) {
            $Model->rollback();
            return false;
        }

        $userInfo = M(SqlManager::TABLE_USERINFO)->where("user_name='%s'", $charInfo['user_name'])
            ->find();
        return $userInfo;
    }

    /**
     * 退出房间
     * @param $sqlData
     * @return false
     */
    public static function exitChatRoom($sqlData,bool $isCreator) {
        $newData['end_time'] = ToolUtil::getCurrentTime();
        $newData['status'] = $sqlData['status'];
        $newData['work'] = 2;

        $sqlStr = sprintf("SELECT a.user_name,a.room_id,a.room_role_type,b.gender FROM xq_chat_user a,xq_user_info b 
            WHERE a.room_id='%s' AND a.user_name='%s' AND a.user_name=b.user_name AND a.`work`<>2",
            $sqlData['room_id'],$sqlData['user_name']);
        $result = M()->query($sqlStr)[0];
//        if(!$result) {
//            return false;
//        }
        $countStr = $result['gender']==Common::MAN?'count_man':'count_lady';
        $Model = M();
        $Model->startTrans();
        try{
            if($isCreator) {
                //是创建者，标识为停止
                M(SqlManager::TABLE_CHAT)->where("room_id='%s'",$sqlData['room_id'])->save($newData);
                M(SqlManager::TABLE_CHAT_USER)->where("room_id='%s' and user_name='%s' and work<>2"
                    ,$sqlData['room_id'],$sqlData['user_name'])->save($newData);
                M(SqlManager::TABLE_CHAT_ROOM)->where("room_id='%s' and inner_id='%s'",
                    $sqlData['room_id'],$sqlData['inner_id'])
                    ->save($newData);
                M(SqlManager::TABLE_CHAT_ROOM_USER)->where("room_id='%s' and inner_id='%s'",
                    $sqlData['room_id'],$sqlData['inner_id'])
                    ->save($newData);
            }else {
                //不是创建者
                M(SqlManager::TABLE_CHAT_USER)->where("room_id='%s' and user_name='%s' and work<>2"
                    ,$sqlData['room_id'],$sqlData['user_name'])->save($newData);
                M(SqlManager::TABLE_CHAT_ROOM)->where("room_id='%s' and inner_id='%s'",
                    $sqlData['room_id'],$sqlData['inner_id'])
                    ->save($newData);
                M(SqlManager::TABLE_CHAT_ROOM_USER)->where("room_id='%s' and user_name='%s' and inner_id='%s'",
                    $sqlData['room_id'],$sqlData['user_name'],$sqlData['inner_id'])
                    ->save($newData);
                //是参与者并且是参与模式（而不是排队模式）则-1
                if($sqlData['joinType'] == 1 && $result['room_role_type'] == 1) {
                    M(SqlManager::TABLE_CHAT)->where("room_id='%s' and work=0",$sqlData['room_id'])
                        ->setDec($countStr,1); //人员数+1
                }
            }

            $Model->commit();
        }catch (\Exception $e) {
            $Model->rollback();
            return false;
        }
        $result = M()->query($sqlStr)[0];
        return $result;
    }

    /**
     * 在预约期间退出房间
     * @param $sqlData
     * @return false
     */
    /*public static function cancelChatRoom($sqlData,$isCreator) {
        $newData['delete_time'] = ToolUtil::getCurrentTime();
        $newData['status'] = -1;
        $newData['work'] = 2;
        $result = '';
        if($isCreator) {
            M(SqlManager::TABLE_CHATROOM)->where("room_id='%s'",$sqlData['room_id'])->save($newData);
            $sqlStr = sprintf("UPDATE xq_room_record SET exit_time='%s', `work`=2,`status`=-1 WHERE room_id='%s'",
                $newData['delete_time'],$sqlData['room_id']);
            $result = M()->execute($sqlStr);
        }else {
            $result = M(SqlManager::TABLE_ROOM_RECORD)->where("room_id='%s' and user_name='%s'"
                ,$sqlData['room_id'],$sqlData['user_name'])->save($newData);
        }
        return $result;
    }*/

    /**
     * 根据用户名获取房间
     * @param $sqlData
     * @return mixed
     */
    public static function getChatRoomByUser($sqlData) {
        $sqlStr = sprintf("SELECT b.*,a.room_role_type FROM xq_chat_user a,xq_chat b WHERE a.user_name='%s' 
            AND a.room_id=b.room_id  AND a.`work`<>2 ORDER BY a.start_time DESC"
            ,$sqlData['user_name']);
        $result = M()->query($sqlStr)[0];
        if(!$result) {
            return null;
        }

        $limitStr = $sqlData['gender']==Common::MAN?'limit_man':'limit_lady';
        $countStr = $sqlData['gender']==Common::MAN?'count_man':'count_lady';
        $isQueue = false;   //是否排队
        if($result[$countStr] >= $result[$limitStr]) {
            $isQueue = true;
        }
        $result['isQueue'] = $isQueue?2:1;
        return $result;
    }


    /**
     * 获取房间的所有参与成员
     * @param $sqlData
     * @return array
     */
    public static function getChatRoomMember($sqlData,$room_role_type) {
        $sqlStr = sprintf("SELECT a.in_room,b.user_name,b.nick_name,b.gender,b.role_type,b.`level`,b.age,b.tall,
                  b.scholling,b.professional,b.native_place,b.marrige,b.job_address,b.head_image,b.special_info 
                  FROM xq_chat_user a,xq_user_info b WHERE a.user_name = b.user_name AND a.room_id='%s' 
                  AND a.room_role_type='%s' AND a.end_time is null ",
            $sqlData['room_id'],$room_role_type);
        $result = M()->query($sqlStr);

        $reArray = [];
        $index = 0;
        $manIndex = 0;
        $angelIndex = 0;
        $ladyIndex = 0;
        $chatInfo = M(SqlManager::TABLE_CHAT)->where("room_id='%s'",$sqlData['room_id'])->find();
        foreach ($result as $item) {
            $resultData = [];
            $item['head_image'] = 'http://'.$_SERVER['SERVER_NAME'].$item['head_image'];
            if($room_role_type == 1) {
                //参与者
                if($item['role_type'] == Common::ROLRTYPE_ANGEL) {
                    //爱心大使
                    if($angelIndex >= $chatInfo['limit_angel']) {
                        //超过爱心大使的人数限制
                        continue;
                    }
                    $index = $angelIndex;
                    $angelIndex++;
                }else {
                    if($item['gender'] == Common::LADY) {
                        //女嘉宾
                        if($ladyIndex >= $chatInfo['limit_lady']) {
                            //超过爱心大使的人数限制
                            continue;
                        }
                        $index = $ladyIndex;
                        $ladyIndex++;
                    }else {
                        //男嘉宾
                        if($manIndex >= $chatInfo['limit_man']) {
                            //超过爱心大使的人数限制
                            continue;
                        }
                        $index = $manIndex;
                        $manIndex++;
                    }
                }

                $resultData['index'] = $index;
            }else {
                $resultData['index'] = $index;
                $index++;
            }
            $resultData['roomRoleType'] = $room_role_type;
            $resultData['inRoom'] = $item['in_room'];
            $resultData['userInfo'] = $item;
            array_push($reArray,$resultData);
        }
        return $reArray;
    }

    /**
     * 开始房间
     * @param $sqlData
     * @return false
     */
    public static function startChatRoom($sqlData) {
        $newData['work'] = 1;  //标记为正在进行中
        $Model = M();
        //将房间的所有人添加到表xq_chat_room_user中，并给这次匹配添加一个id
        $inner_id = 'R'.ToolUtil::createUniqueNumber();
        $Model->startTrans();
        try{
            //添加一个记录到xq_chat_room种，用来记录本次匹配
            $result = M(SqlManager::TABLE_CHAT)->where("room_id='%s'",$sqlData['room_id'])->field("id",true)->find();
            M(SqlManager::TABLE_CHAT)->where("room_id='%s' and work<>2",
                $sqlData['room_id'])->save($newData);
            $result['status'] = 0;
            $result['start_time'] = ToolUtil::getCurrentTime();
            $result['inner_id'] = $inner_id;
            M(SqlManager::TABLE_CHAT_ROOM)->add($result);
            M(SqlManager::TABLE_CHAT_USER)->where("room_id='%s' and work<>2 and in_room=1",
                $sqlData['room_id'])->save($newData);
            $Model->commit();
        }catch (\Exception $e) {
            LogUtil::writeAppLog("Fail--startChatRoom:".json_encode($e));
            $Model->rollback();
            return false;
        }

        //在房间内的,则将人员添加到xq_chat_user表中
        $result = M(SqlManager::TABLE_CHAT_USER)->where("room_id='%s' and work<>2 and in_room=1",
            $sqlData['room_id'])->field("id",true)->select();
        for($i = 0 ; $i < count($result) ; $i++) {
            $result[$i]['inner_id'] = $inner_id;
            $result[$i]['start_time'] = ToolUtil::getCurrentTime();
        }

        $Model->startTrans();
        try{
            M(SqlManager::TABLE_CHAT_ROOM_USER)->addAll($result);
            $Model->commit();
        }catch (\Exception $e) {
            LogUtil::writeAppLog("Fail--startChatRoom:".json_encode($e));
            $Model->rollback();
            return false;
        }

        $returnData['inner_id'] = $inner_id;
        return $returnData;
    }

    /**
     * 获取房间列表
     * @param $sqlData
     * @return mixed
     */
    public static function getChatRoomList($sqlData) {
        $where = [];
        if($sqlData['public'] != -1) {
            $strArray = explode(',',$sqlData['public']);
            $where['public'] = array('in',$strArray);
        }
        if($sqlData['work'] != -1) {
            $strArray = explode(',',$sqlData['work']);
            $where['work'] = array('in',$strArray);
        }
        if($sqlData['status'] != -2) {
            $strArray = explode(',',$sqlData['status']);
            $where['status'] = array('in',$strArray);
        }

        $result = M(SqlManager::TABLE_CHAT)->where($where)->select();
        return $result;
    }

    /**检测房间是否过期
     * 子调用方法
     * @return false
     */
    public static function subCheckExpiryChatRoom() {
        $createTime_limit = ToolUtil::getTimeStrByTime(time()-2*60*60);//两个小时前
        $appointTime_limit = ToolUtil::getTimeStrByTime(time()-15*60);//15分钟
        //取出开始并且两小时还没结束获取已经预约大于15分钟才没开始的
        $sqlStr = sprintf("SELECT * FROM xq_chat WHERE (start_time<='%s' AND `work`=1) 
                  OR (appoint_time<'%s' AND `work`=0)",
            $createTime_limit,$appointTime_limit);
        $sqlResult = M()->query($sqlStr);
        foreach ($sqlResult as $info) {
            //设置结束
            M(SqlManager::TABLE_CHAT)->where("room_id='%s'",$info['room_id'])->setField(array('work'=>2,'status'=>-1));
        }
        return $sqlResult;
    }

    /**
     * 获取赠送的礼物
     * @param $sqlData
     * @return array
     */
    public static function getBonusByUser($sqlData) {
        $sqlStr = sprintf("SELECT a.*,b.`name`,c.`name` as gift_name,c.image FROM xq_bonus_user a,
            xq_bonus_item b,xq_gift_item c WHERE a.bonus_id=b.id AND a.user_name='%s' AND a.gift_id=c.gift_id 
            AND a.`status`='%s' ORDER BY create_time",
            $sqlData['user_name'],$sqlData['status']);
        $sqlResult = M()->query($sqlStr);
        //分批次
        $mapBonus = [];
        foreach ($sqlResult as $item) {
            $key = $item['bonus_id'];
            $info = [];
            if(!is_null($mapBonus[$key]) && $mapBonus[$key]['create_time'] == $item['create_time']) {
                $info = $mapBonus[$key];
            }else {
                $mapBonus[$key] = $info;
            }
            $info['bonus_id'] = $key;
            $info['bonus_name'] = $item['name'];
            $info['create_time'] = $item['create_time'];
            if(is_null($info['gift'])) {
                $info['gift'] = [];
            }
            $gift_info = [];
            $gift_info['gift_id'] = $item['gift_id'];
            $gift_info['name'] = $item['gift_name'];
            $gift_info['num'] = $item['num'];
            $gift_info['create_time'] = $item['create_time'];
            $gift_info['modify_time'] = $item['modify_time'];
            $gift_info['image'] = 'http://'.$_SERVER['SERVER_NAME'].$item['image'];
            array_push($info['gift'],$gift_info);
            $mapBonus[$key] = $info;
        }

        $reArray = [];
        foreach ($mapBonus as $item) {
            array_push($reArray,$item);
        }
        return $reArray[0];
    }

    public static function receiveBonus($sqlData) {
        $newData['status'] = 1;
        $newData['modify_time'] = ToolUtil::getCurrentTime();
        $Model = M();
        $Model->startTrans();
        try{
           M(SqlManager::TABLE_BONUS_USER)->where("user_name='%s' and bonus_id='%s' and status=0",
                $sqlData['user_name'],$sqlData['bonus_id'])->save($newData);
           $infoArray = M(SqlManager::TABLE_BONUS_USER)->where("user_name='%s' and bonus_id='%s' and status=1",
               $sqlData['user_name'],$sqlData['bonus_id'])->field('gift_id,user_name,num')->select();
           foreach ($infoArray as $item) {
               //添加到个人的礼物中
               $sql = M(SqlManager::TABLE_GIFT_USER);
               $sqlResult = $sql->where("user_name='%s' and gift_id='%d' and status=0",
                   $item['user_name'],$item['gift_id'])->find();
               if($sqlResult) {
                   $sql->where("user_name='%s' and gift_id='%d' and status=0",$item['user_name'],$item['gift_id'])
                       ->setInc('num',$item['num']);
               }else {
                   $insertData['gift_id'] = $item['gift_id'];
                   $insertData['user_name'] = $item['user_name'];
                   $insertData['num'] = $item['num'];
                   $sql->add($insertData);
               }
           }
           $Model->commit();
        }catch (\Exception $e) {
            $Model->rollback();
            return false;
        }
        return true;
    }

    /**
     * 获取我的收益
     * @param $sqlData
     * @return mixed
     */
    public static function getProfitByUser($sqlData) {
        $sqlStr = sprintf("SELECT a.*,b.user_name FROM xq_chat_room a,xq_chat b WHERE a.room_id=b.room_id 
            AND b.user_name='%s'",$sqlData['user_name']);
        $roomArray = M()->query($sqlStr);
        $allCount = 20;
        $successCount = 10;
        $reportRate = 0.05;
        $isCanExchange = true;

        $self_successCount = 0;
        $self_allCount = 0;
        $self_reportCount = 0;
        $self_rate = 0;

        $reData['allCount'] = $allCount;
        $reData['successCount'] = $successCount;
        $reData['reportRate'] = $reportRate;
        $self_allCount = count($roomArray);
        if(count($roomArray) < $allCount) {
            $isCanExchange = false;
        }else {
            $success = 0;
            foreach ($roomArray as $item) {
                if($item['status'] == 1) {
                    //成功
                    $success ++;
                }
            }
            $self_successCount = $success;
            if($success < $successCount) {
                $isCanExchange = false;
            }
        }
        if(!$isCanExchange) goto result;

        //判断被举报的次数
        $sqlStr = sprintf("SELECT *,COUNT(inner_id) as count FROM xq_user_report GROUP BY inner_id");
        $roomArray = M()->query($sqlStr);
        $reportCunt = 0;
        foreach ($roomArray as $item) {
            if($item['count'] >= Common::REPORT_VALID_COUNT) {
                $reportCunt ++;
            }
        }
        $self_reportCount = $reportCunt;
        $rate = (float)$reportCunt/count($roomArray);
        $self_rate = $rate;
        if($rate >= $reportRate) {
            $isCanExchange = false;
        }
        goto result;

        result:
            $reData['is_exchange'] = $isCanExchange?1:0;
            $userInfo = M(SqlManager::TABLE_USERINFO)->where("user_name='%s'",$sqlData['user_name'])->field('balance')
                ->find();
            $reData['balance'] = $userInfo['balance'];
            $reData['allCount'] = $allCount;
            $reData['self_successCount'] = $self_successCount;
            $reData['self_allCount'] = $self_allCount;
            $reData['self_reportCount'] = $self_reportCount;
            $reData['self_rate'] = $self_rate;
            return $reData;
    }
}
