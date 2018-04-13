<?php

/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

namespace Sample_Mjmz\Controller;
use Sample_Mjmz\Controller\BaseController;
use JMessage\JMessage;
use Sample_Mjmz\Custom\Jchart\JMChartRoomHandler;
use Sample_Mjmz\Custom\Joptions\JchartRoomOptions;

class JMessageController extends BaseController {
    private $JMClient;
    private $appKey = 'd4f1d053cfdba36011487fea';
    private $masterSecret = '78eddf9e1636ecc3397f0fa9';

    public function __construct() {
        parent::__construct();
        $this->JMClient = new JMessage($this->appKey, $this->masterSecret);
    }

    public function index() {
        $this->returnData($this->convertReturnJsonSucessed('welcome to JMessage'));
    }
    
    /**
     * 创建聊天室
     */
    public function createChartRoom() {
        $option = new JchartRoomOptions();
        $option->jmClient = $this->JMClient;
        $chartHandler = new JMChartRoomHandler($option);
        $chartHandler->createChartRoom();
        $roomId = $chartHandler->getChartRoomId();
        $this->_waitChartRoomArray[$roomId] = $chartHandler;
        echo $chartHandler->getRestCount()."--roomId=".$chartHandler->getChartRoomId().'</br>';
    }

        public function listUsers() {
        $roomId = $_GET['roomId'];
        $chartRoomHandler = $this->_charmRoomArray[$roomId];
        if($chartRoomHandler === NULL) {
            $chartRoomHandler = new JMChartRoomHandler($this->JMClient);
            $this->_charmRoomArray[$roomId] = $chartRoomHandler;
        }
        echo $chartRoomHandler->listUsers();
    }
    
    public function showUser() {
        if(isset($this->JMUser)) {
            $username = $_GET['userName'];
            $result = $this->JMUser->show($username);
            echo $result.'--username='.$result['body']['username'];
        }
    }
}

