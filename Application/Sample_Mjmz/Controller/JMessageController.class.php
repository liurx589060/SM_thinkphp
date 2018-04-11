<?php

/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

namespace Sample_Mjmz\Controller;
use Sample_Mjmz\Controller\BaseController;
use JMessage\JMessage;
use JMessage\IM\User;

class JMessageController extends BaseController {
    private $JMClient;
    private $appKey = 'd4f1d053cfdba36011487fea';
    private $masterSecret = '78eddf9e1636ecc3397f0fa9';
    
    private $JMUser;

    public function __construct() {
        parent::__construct();
        $this->JMClient = new JMessage($this->appKey, $this->masterSecret);
        $this->JMUser = new User($this->JMClient);
    }

    public function index() {
        $this->returnData($this->convertReturnJsonSucessed('welcome to JMessage'.'--'.$this->JMClient->getAuth()));
    }
    
    public function listUsers() {
        if(isset($this->JMUser)) {
            $result = $this->JMUser->listAll(100);
            echo count($result);
        }
    }
    
    public function showUser() {
        if(isset($this->JMUser)) {
            $username = $_GET['userName'];
            $result = $this->JMUser->show($username);
            echo $result.'--username='.$result['body']['username'];
        }
    }
}

