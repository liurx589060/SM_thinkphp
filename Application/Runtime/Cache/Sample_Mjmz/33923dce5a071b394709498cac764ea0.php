<?php if (!defined('THINK_PATH')) exit();?><!DOCTYPE html>
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->
<html>
    <head>
        <title><?php echo ($title); ?></title>
        <meta charset='UTF-8'>
        <meta name='viewport' content='width=device-width, initial-scale=1.0'>
        <style type='text/css'><?php echo ($css); ?></style>
        <script type='text/javascript'><?php echo ($javascript); ?></script>
    </head>
    <body onload='load()'>
        <div><?php echo ($content); ?></div>
    </body>
</html>