<?php if (!defined('THINK_PATH')) exit();?><!DOCTYPE html>
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->
<html>
    <head>
        <title>表单添加用户</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
    </head>
    <body>
        <div>
            <FORM method="post" action="/thinkphp/index.php/Sample_Mjmz/Test/addUserByForm">
                  用户id：<INPUT type="text" name="id"><br/>
                  内容：<TEXTAREA name="data" rows="5" cols="45"></TEXTAREA><br/>
                  <INPUT type="submit" value="提交">
            </FORM>
        </div>
    </body>
</html>