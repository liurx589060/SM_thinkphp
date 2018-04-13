<?php

/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
namespace Sample_Mjmz\Custom\Jchart;
use JMessage\IM\User;
use Sample_Mjmz\Custom\Joptions\JchartRoomOptions;

const MAN = 1000;  //男士
const LADY = 1001; //女生
const MIX = 1002;  //剩余
const FULL = 1003; //满员

class JMChartRoomHandler {
    private $_JMClient;
    private $_JMUser;
    private $_restGender = MIX; //剩余性别
    private $_countMan = 0;//男生数量
    private $_countLady = 0;//女生数量
    private $_limitCount = 0;//人数总数，默认12个
    private $_limitLevel = -1;//等级区域，默认-1，-1则表示不做等级的限制 
    private $_chartRoomId = -1;//聊天室的Id


    public function __construct(JchartRoomOptions $options) {
        $this->_JMClient = $options->jmClient;
        $this->_JMUser = new User($this->_JMClient);
        $this->_limitCount = $options->limitCount;
        $this->_limitLevel = $options->limitLevel;
    }
    
    public function listUsers() {
        $result = $this->_JMUser->listAll(100);
        return count($result);
    }
    
    public function showUser() {
        $username = $_GET['userName'];
        $result = $this->_JMUser->show($username);
        return $result.'--username='.$result['body']['username'];
    }
    
    public function createChartRoom() {
        $this->_chartRoomId = rand(5600, 10000);
        return TRUE;
    }

        /**
     * 获取剩余的性别
     */
    public function getRestGender() {
        $limit = $this->_limitCount/2;
        if($this->_countMan < $limit) {//男生少于平均
            if($this->_countLady < $limit) {//女生也少于平均
                $this->_restGender = MIX;
            } else {
                $this->_restGender = MAN;
            }
        } else {//男生人数大于等于平均
            if($this->_countLady < $limit) {//女生少于平均
                $this->_restGender = LADY;
            } else {
                $this->_restGender = FULL;
            }
        }
        return $this->_restGender;
    }
    
    /**
     * 获取剩余人数
     * @return type
     */
    public function getRestCount() {
        $num = $this->_limitCount - $this->_countMan - $this->_countLady;
        if($num <= 0) {
            $this->_restGender = FULL;
        }
        return $num;
    }
    
    /**
     * 获取聊天室房间Id
     * @return type
     */
    public function getChartRoomId() {
        return $this->_chartRoomId;
    }
}

