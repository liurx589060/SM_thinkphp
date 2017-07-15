<?php if (!defined('THINK_PATH')) exit();?><!DOCTYPE html>
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->
<html>
    <head>
        <title>表单添加和修改用户信息</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
    </head>
    <body>
        <div>
            <FORM method="post" action="/thinkphp/index.php/Sample_Mjmz/Web/addUserByForm">
                  <!--用户id：<INPUT type="text" name="userId"><br/>-->
                  内容：<TEXTAREA name="user_data" rows="5" cols="45"></TEXTAREA><br/>
                  <INPUT type="submit" value="提交">
                  <INPUT type="reset" value="清空">
            </FORM>
        </div>
        
        <p></p>
        
        <div style="background-color: #aaaaaa;margin-top: 50px">
            <FORM method="post" action="/thinkphp/index.php/Sample_Mjmz/Web/updataUserByForm">
                  用户id：<INPUT type="text" name="user_id"><br/>
                  内容：<TEXTAREA name="user_data" rows="5" cols="45"></TEXTAREA><br/>
                  <INPUT type="submit" value="修改">
                  <INPUT type="reset" value="清空">
            </FORM>
        </div>
    </body>
</html>