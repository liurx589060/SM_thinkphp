<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2019/3/18
 * Time: 21:32
 */

namespace Sample_Mjmz\Controller;


use Sample_Mjmz\Utils\SqlManager;
use Sample_Mjmz\Utils\Common;
use Sample_Mjmz\Utils\ToolUtil;
use JPush;

class PayController extends BaseController {
    private $JPushClient;  //极光推送

    public function index(){
        echo 'welcome to Pay'.'-->>'.'Sy!';
    }

    function __construct()
    {
        $this->JPushClient = new JPush(Common::JM_appKey, Common::JM_masterSecret);
    }

    /**
     * http://localhost/thinkphp/Sample_Mjmz/Pay/getPayItem
     * 获取支付项目
     */
    public function getPayItem() {
        $result = SqlManager::getPayItem();
        $this->returnData($this->convertReturnJsonSucessed($result));
    }

    /**
     * http://localhost/thinkphp/Sample_Mjmz/Pay/makePayOrder?type=1&userName=wys30201&payType=1&coin=60&money=6
     * 创建支付订单
     */
    public function makePayOrder() {
        $user_name = $_GET['userName'];
        $pay_type = $_GET['payType'];
        $coin = $_GET['coin'];
        $money = $_GET['money'];
        if(is_null($user_name) || is_null($pay_type) || is_null($coin) || is_null($money)) {
            $this->returnData($this->convertReturnJsonError(Common::ERROR_LACK_PARAMS ,
                'lack userName，payType,coin,money'));
            return ;
        }
        $sqlData['user_name'] = $user_name;
        $sqlData['pay_type'] = (int)$pay_type;
        $sqlData['coin'] = (int)$coin;
        $sqlData['money'] = (int)$money;
        $orderId = 'O'.ToolUtil::createUniqueNumber();
        $sqlData['order_id'] = $orderId;
        $sqlData['status'] = 0;
        $sqlData['create_time'] = time();

        $sqlResult = SqlManager::makePayOrder($sqlData);
//        $this->returnData($this->convertReturnJsonSucessed($sqlResult));
        $this->returnData($this->convertReturnJsonSucessed($sqlData));
    }

    /**
     * http://localhost/thinkphp/Sample_Mjmz/Pay/handlePayCallback?orderId=O2019031997100495
     * 支付回调
     */
    public function handlePayCallback() {
        $order_id = $_GET['orderId'];
        if(is_null($order_id)) {
            $this->returnData($this->convertReturnJsonError(Common::ERROR_LACK_PARAMS ,
                'lack orderId'));
            return ;
        }

        $sqlData['order_id'] = $order_id;
        $sqlData['status'] = 1;   //支付成功
        $sqlData['serial_id'] = ToolUtil::createUniqueNumber();
        $sqlData['modify_time'] = time();
        $SqlResult = SqlManager::handlePayCallback($sqlData);
        if($SqlResult == -1) {
            $this->returnData($this->convertReturnJsonError(Common::ERROR , '订单支付回调处理失败'));
        }else if($SqlResult == -2){
            $this->returnData($this->convertReturnJsonError(Common::ERROR , '订单已经处理'));
        }else if($SqlResult){
            //极光推送到客户端
            $pusher = $this->JPushClient->push();
            $pusher->setPlatform('all');
            $pusher->addTag(Common::JPUSH_TAG_CHAT);
            $extraArray['type'] = Common::JPUSH_TYPE_PAY_SUCCESS;
            $extraArray['data'] = $SqlResult;
            $pusher->setMessage(json_encode($extraArray),'create','json',null);
            try {
                $pusher->send();
            } catch (JPushException $e) {
                // try something else here
                print $e;
            }
            $this->returnData($this->convertReturnJsonSucessed($SqlResult));
        }
    }

    /**
     * http://localhost/thinkphp/Sample_Mjmz/Pay/getPayHistory?userName=wys30201&status=1
     * 获取礼品项目
     */
    public function getPayHistory() {
        $user_name = $_GET['userName'];
        $status = $_GET['status'];
        if(is_null($user_name) || is_null($status)) {
            $this->returnData($this->convertReturnJsonError(Common::ERROR_LACK_PARAMS ,
                'lack userName，status'));
            return ;
        }

        $sqlData['user_name'] = $user_name;
        $sqlData['status'] = $status;
        $result = SqlManager::getPayHistory($sqlData);
        $this->returnData($this->convertReturnJsonSucessed($result));
    }

    /**
     * http://localhost/thinkphp/Sample_Mjmz/Pay/getGiftItem?position=1
     * 获取礼品项目
     */
    public function getGiftItem() {
        $position = $_GET['position'];
        if(is_null($position)) {
            $this->returnData($this->convertReturnJsonError(Common::ERROR_LACK_PARAMS ,
                'lack position'));
            return ;
        }

        $result = SqlManager::getGiftItem($position);
        $this->returnData($this->convertReturnJsonSucessed($result));
    }

    /**
     * http://localhost/thinkphp/Sample_Mjmz/Pay/buyGiftByCoin?userName=wys30201&giftId=2&coin=2
     * 用钻石购买礼物
     */
    public function buyGiftByCoin() {
        $user_name = $_GET['userName'];
        $gift_id = $_GET['giftId'];
        $coin = $_GET['coin'];

        if(is_null($user_name) || is_null($gift_id) || is_null($coin)) {
            $this->returnData($this->convertReturnJsonError(Common::ERROR_LACK_PARAMS ,
                'lack userName，giftId,coin'));
            return ;
        }
        $sqlData['user_name'] = $user_name;
        $sqlData['gift_id'] = $gift_id;
        $sqlData['coin'] = $coin;
        $sqlData['to_user'] = $user_name;  //标识去向为自己
        $sqlData['create_time'] = time();

        $result = SqlManager::buyGiftByCoin($sqlData);
        $this->returnData($this->convertReturnJsonSucessed($result));
    }

    /**
     * http://localhost/thinkphp/Sample_Mjmz/Pay/getGiftListByUserName?userName=wys30201
     * 获取自己礼物列表
     */
    public function getGiftList() {
        $user_name = $_GET['userName'];
        if(is_null($user_name)) {
            $this->returnData($this->convertReturnJsonError(Common::ERROR_LACK_PARAMS ,
                'lack userName'));
            return ;
        }

        $sqlData['user_name'] = $user_name;
        $result = SqlManager::getGiftList($sqlData);
        $this->returnData($this->convertReturnJsonSucessed($result));
    }

    /**
     * http://localhost/thinkphp/Sample_Mjmz/Pay/getConsumeHistory?userName=wys30201
     * 获取自己的消费记录
     */
    public function getConsumeHistory() {
        $user_name = $_GET['userName'];
        if(is_null($user_name)) {
            $this->returnData($this->convertReturnJsonError(Common::ERROR_LACK_PARAMS ,
                'lack userName'));
            return ;
        }

        $sqlData['user_name'] = $user_name;
        $result = SqlManager::getConsumeHistory($sqlData);
        $this->returnData($this->convertReturnJsonSucessed($result));
    }

    /**
     * http://localhost/thinkphp/Sample_Mjmz/Pay/consumeGift?userName=wys30201&giftId=2&coin=2&toUser=wys30202handleType=1
     * 用消费礼物
     */
    public function consumeGift() {
        $user_name = $_GET['userName'];
        $gift_id = $_GET['giftId'];
        $coin = $_GET['coin'];
        $to_user = $_GET['toUser'];  //目标用户
        $handleType = $_GET['handleType'];  //1:直接金币消费   2：从我的包裹中消费

        if(is_null($user_name) || is_null($gift_id) || is_null($coin) || is_null($to_user) || is_null($handleType)) {
            $this->returnData($this->convertReturnJsonError(Common::ERROR_LACK_PARAMS ,
                'lack userName，giftId,coin,toUser,handleType'));
            return ;
        }
        $sqlData['to_user'] = $to_user;
        $sqlData['user_name'] = $user_name;
        $sqlData['gift_id'] = $gift_id;
        $sqlData['coin'] = $coin;
        $sqlData['create_time'] = time();
        $sqlData['handleType'] = $handleType;

        $result = SqlManager::consumeGift($sqlData);
        if($result == 0) {
            $this->returnData($this->convertReturnJsonError(Common::ERROR_GIFT_LACK_STOCK ,
                'lack gift stock'));
        }
        $this->returnData($this->convertReturnJsonSucessed($result));
    }

    /**
     *http://localhost/thinkphp/Sample_Mjmz/Pay/checkRoomExpiry?userName=wys30201&type=1
     * 创房间的时候检测是否免费的卡
     */
    public function checkRoomExpiry() {
        $user_name = $_GET['userName'];
        $handleType = $_GET['handleType'];   //1: 创建房间   2;加入房间
        if(is_null($user_name) || is_null($handleType)) {
            $this->returnData($this->convertReturnJsonError(Common::ERROR_LACK_PARAMS ,
                'lack userName,handleType'));
            return ;
        }

        $data['user_name'] = $user_name;
        $data['handleType'] = $handleType;
        $result = SqlManager::checkCreateRoomExpiry($data);
        $this->returnData($this->convertReturnJsonSucessed($result));
    }

}