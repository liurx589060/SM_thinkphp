<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2019/5/23
 * Time: 21:38
 */

namespace Shici\Controller;


class ApiController extends BaseController
{
    public function request() {
        $this->returnData($this->convertReturnJsonSucessed());
    }
}