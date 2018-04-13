<?php

/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
namespace Sample_Mjmz\Custom;
use Sample_Mjmz\Custom\Jchart\JMChartRoomHandler;

class JchartRoomDataManager {
    static private $instance;
    
    private $_waitChartRoomArray;  //未满员，等待的聊天室
    private $_startedChartRoomArray; //满员，开始了的聊天室
    
    private function __construct(){
        
    }
    
    //防止克隆对象
    private function __clone(){

    }
    
    function __destruct() {
        unset($this->_waitChartRoomArray);
        unset($this->_startedChartRoomArray);
   }
    
    static public function getInstance(){
        if (!self::$instance instanceof self) {
            self::$instance = new self($config);
        }
        return self::$instance;
    }
    
    public function addWaitChartRoom(JMChartRoomHandler $handler) {
        if(!isset($this->_waitChartRoomArray)) {
            $this->_waitChartRoomArray = array();
        }
        $this->_waitChartRoomArray[$handler->getChartRoomId()] = $handler;
        return TRUE;
    }
    
    public function removeWaitChartRoom(JMChartRoomHandler $handler) {
        if(!isset($this->_waitChartRoomArray)) {
            return FALSE;
        }
        if(!array_key_exists($handler->getChartRoomId(), $this->_waitChartRoomArray)){  
            echo 'waitChartRoomArray not contain the handler';
            return TRUE;  
        }  
        $keys = array_keys($this->_waitChartRoomArray);  
        $index = array_search($handler->getChartRoomId(), $keys);  
        if($index !== FALSE){  
            array_splice($this->_waitChartRoomArray, $index, 1);
        }
        return TRUE;
    }  

    public function addStartedChartRoom(JMChartRoomHandler $handler) {
        if(!isset($this->_startedChartRoomArray)) {
            $this->_startedChartRoomArray = array();
        }
        $this->_startedChartRoomArray[$handler->getChartRoomId()] = $handler;
        return TRUE;
    }
    
    public function removeStartedChartRoom(JMChartRoomHandler $handler) {
        if(!isset($this->_startedChartRoomArray)) {
            return FALSE;
        }
        if(!array_key_exists($handler->getChartRoomId(), $this->_startedChartRoomArray)){  
            echo 'startedChartRoomArray not contain the handler';
            return TRUE;  
        }  
        $keys = array_keys($this->_startedChartRoomArray);  
        $index = array_search($handler->getChartRoomId(), $keys);  
        if($index !== FALSE){  
            array_splice($this->_startedChartRoomArray, $index, 1);
        }
        return TRUE;
    }
    
    public function destroyChartRoom(JMChartRoomHandler $handler) {
        $this->removeWaitChartRoom($handler);
        $this->removeStartedChartRoom($handler);
        echo 'destroyChartRoom-'.$handler.'--roomId='.$handler->getChartRoomId();
        unset($handler);
    }
}
