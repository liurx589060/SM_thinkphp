<?php

/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
namespace Sample_Mjmz\Self\Jchart;
use JMessage\IM\User;

class JMChartRoomHandler {
    private $_JMClient;
    private $_JMUser;
    
    public function __construct($JMClient) {
        $this->_JMClient = $JMClient;
        $this->_JMUser = new User($this->_JMClient);
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
}

