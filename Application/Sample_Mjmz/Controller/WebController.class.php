<?php

/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

namespace Sample_Mjmz\Controller;
use Sample_Mjmz\Controller\BaseController;

define('TABLE_USER', 'User');
define('TABLE_HEAD_IMAGE', 'Head_image');
define('TABLE_USER_INFO', 'User_info');
define('TABLE_HTML','Html');

class WebController extends BaseController {
    public function index(){
        echo 'Welcome WebController';
    }
    
    /**
     * 通过网页表单添加用户
     */
    public function addUserByForm() {
        $User = D(TABLE_USER);
        if($User->create()) {
            $result = $User->add();
            if($result) {
                $this->success('数据添加成功！');
            } else {
                $this->error('数据添加错误！');
            }
        } else {
            $this->error($User->getError());
        }
    }
    
    /**
     * 通过网页表单修改用户
     */
    public function updataUserByForm() {
        $User = D(TABLE_USER);
        if($User->create()) {
            $User->modify_time = time();
            $result = $User->save();
            if($result) {
                $this->success('数据修改成功！');
            } else {
                $this->error('数据修改错误！');
            }
        } else {
            $this->error($User->getError());
        }
    }
    
    /**
     * 上传
     */
    public function uploadByForm() {
        $userId = $_POST['user_id']; 
        if(empty($userId)) {
            $this->error('usrid必须填写');
            return;
        }
        $config = array(
            'maxSize'    =>    8*1024*1024,
            'rootPath'   =>    './',
            'savePath'   =>    'file/headImage/',
            'saveName'   =>    array('uniqid',''),
            'replace'    =>    true,
            'exts'       =>    array('jpg', 'gif', 'png', 'jpeg'),
            'autoSub'    =>    true,
            'subName'    =>    $userId,
        );
        $upload = new \Think\Upload($config);
        $User = M(TABLE_USER);
        $userInfo = $User->where('user_id=%d',$userId)->select();
        if($userInfo) {
            //上传
            $info = $upload->upload();
            if($info) {
                $Head_image = M(TABLE_HEAD_IMAGE);
                foreach ($info as $file) {                  
                    $d['head_image'] = $file['savepath'].$file['savename'];
                    $d['modify_time'] = time();
                    $User->where('user_id=%d',$userId)->save($d);
                    
                    $d['create_time'] = time(); 
                    $d['user_id'] = $userId;
                    $Head_image->add($d);
                    
                    $this->success('上传成功');
                } 
            }else {
                $this->error($upload->getError());
            }                                    
        } else {
            $this->error('没有该用户');
        }
    }
    
    /**
     * 添加用户详细数据
     * @return type
     */
    public function addUserInfoByForm() {
        $userId = $_POST['user_id'];
        if(empty($userId)) {
            $this->error('usrid必须填写');
            return;
        }
        
        $User = M(TABLE_USER);
        $UserInfo = D(TABLE_USER_INFO);
        $UserInfo->create();
        $isUser = $User->where('user_id=%d',$userId)->select();
        if(!$isUser) {
            $this->error('没有该用户');
            return;
        }
        
        $isUserFrInfo = $UserInfo->where('user_id=%d',$userId)->select();
        $result;
        if($isUserFrInfo) {
            $result = $UserInfo->where('user_id=%d',$userId)->save();
        } else {
            $result = $UserInfo->add();
        }
        echo $UserInfo->getLastSql();
        if($result) {
            $this->success('数据添加成功！');
        } else {
            $this->error('数据添加错误！');
        }     
    }
    
    /**
     * 跳转到皇马新闻网页
     */
    public function madridNews() {
        $content = "<div id='main'>
<div id='titleDiv'>
    <label id='title'><big><font color='#354678'>官方：皇马将于12月13日出战世俱杯</font></big></label><br>
    <label id='currentTime'>07-22 07：44：59 皇马官网</label><p>
</div>
<div id='content'>
    <img class='pic' src='http://img1.dongqiudi.com/fastdfs/M00/11/97/oYYBAFhw3q6AOVVDAAHV0V10KoM520.jpg' onclick='imageOnClick(src)'>
    <div style='text-align: center'><u>C罗领取金球奖</u></div>
    <p class='text'>直播吧7月22日讯 作为欧冠改制以来的第一支卫冕球队，皇马将于12月13日踏上世俱杯的征程，他们也有望卫冕世俱杯的冠军。</p>
    <img class='pic' src='http://www.sxdaily.com.cn/NMediaFile/2016/1213/SXRB201612130918000207152431133.jpg' onclick='imageOnClick(src)'>
    <p class='text'>今年世俱杯的举办地点是阿拉伯联合酋长国，决赛时间是12月16日。欧冠冠军皇马将于12月13日参加半决赛的比赛，半决赛的对手目前还不得而知
        。决赛的时间是12月16日当地时间晚上9点，同时三四名决赛也是于当天下午6点进行，三场比赛的地点都是在阿布扎比的扎耶德体育城。</p>
    <img class='pic' src='http://img1.dongqiudi.com/fastdfs1/M00/7F/62/pIYBAFkvkfWAL_xeAAJhPUgBtic469.jpg' onclick='imageOnClick(src)'>
    <p class='text'>今年世俱杯将于12月6日在阿布扎比拉开战幕，届时包括欧洲、非洲、南美洲、亚洲、、大洋洲的冠军以及东道主代表球队为世俱杯展开拼搏。</p>
    <p class='text'>(Mselin)</p>
</div>
</div>";
        
        $css = "#main {
            margin-left: 8pt;
            margin-right: 8pt;
            margin-top: 12pt;
            font-family: 微软雅黑;
            /*background-color: #cccccc;*/
        }

        #title {
            font-size: 15pt;
            font-weight: bold;
        }

        #currentTime {
            font-size: 10pt;
            font-weight: bold;
            color: #666666;
            margin-top: 10pt;
        }

       .pic {
           width: 100%;
        }

        .text {
            text-indent: 2em;
        }";
        
        $javaScript = "var imageArray = new Array();
        Date.prototype.Format = function (fmt) {
            var o = {
                'M+': this.getMonth() + 1,
                'd+': this.getDate(),
                'H+': this.getHours(),
                'm+': this.getMinutes(),
                's+': this.getSeconds(),
                'q+': Math.floor((this.getMonth() + 3) / 3),
                'S': this.getMilliseconds()
            };
            if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + '').substr(4 - RegExp.$1.length));
            for (var k in o)
                if (new RegExp('(' + k + ')').test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (('00' + o[k]).substr(('' + o[k]).length)));
            return fmt;
        };
        function load() {
            var time = (new Date()).Format('MM-dd HH:mm:ss');
            document.getElementById('currentTime').innerHTML = time + '  皇马官网';
            getImageUrlList();

            if(window.rsWeb) {
                window.rsWeb.webLoadComplete(document.body.scrollHeight);
            }
            alert(document.body.scrollHeight);
        };

        function getImageUrlList() {
            var array = document.getElementsByTagName('img');
            for (var i = 0 ; i < array.length ; i++) {
                imageArray[i] = array[i].src;
            }
        };

        function imageOnClick(src) {
            var index;
            for (var i=0;i<imageArray.length;i++) {
                if(src===imageArray[i]) {
                    index = i;
                    break;
                }
            }
            alert(src+'--->>'+index);
            if(window.rsWeb) {
                window.rsWeb.imageOnClick(imageArray,i);
            }
        };";
        $id = $_GET['id'];
        $keyWord = '皇马新闻'.$id;      
        if(empty($id)) {
            $this->error("缺少id参数");
            return;
        }
        
        $Html = D(TABLE_HTML); 
        //判断是否存在
        $info = $Html->where("id='%d'",$id)->select();
        $info = $info[0];
//        echo $Html->getLastSql();       
        
        $a['key_word'] = $keyWord;
        //去掉回车
        $a['css'] = str_replace(array("\r\n", "\r", "\n"), "", $css);
        $a['javascript'] = str_replace(array("\r\n", "\r", "\n"), "", $javaScript);
        $a['html'] = str_replace(array("\r\n", "\r", "\n"), "", $content);  
        $a['id'] = $id;
        if($info) {//数据库中已经存在
            if($a['key_word'] !== $info['key_word'] || 
               $a['css'] !== $info['css'] ||
               $a['javascript'] !== $info['javascript'] ||
               $a['html'] !== $info['html']) {
                
                $Html->save($a);
            }
            $keyWord = $info['key_word'];
            $css = $info['css'];
            $javaScript = $info['javascript'];
            $content = $info['html'];             
        } else {
            $Html->add($a);
        }
                 
        $array['title'] = $keyWord;
        $array['content'] = $content;
        $array['css'] = $css;
        $array['javascript'] = $javaScript;
        $this->assign($array);
        $this->display();       
    }
}

