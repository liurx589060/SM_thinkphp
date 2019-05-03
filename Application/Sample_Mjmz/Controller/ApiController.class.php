<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2019/4/12
 * Time: 23:33
 */

namespace Sample_Mjmz\Controller;


use Sample_Mjmz\Utils\SqlManager;

class ApiController extends BaseController
{
    /**
     * http://localhost/thinkphp/Sample_Mjmz/Api/getAppSettings
     * 检查是否需要更新
     */
    public function getAppSettings() {
        $result = M(SqlManager::TABLE_APP_SETTINGS)->select();
        $this->returnData($this->convertReturnJsonSucessed($result[0]));
    }

    /**
     * http://localhost/thinkphp/Sample_Mjmz/Api/checkUpdate?versionCode=1
     * 检查是否需要更新
     */
    public function checkUpdate() {
        $version_code = $_GET['versionCode'];
        if(is_null($version_code)) {
            $this->returnData($this->convertReturnJsonError(Common::ERROR_LACK_PARAMS ,
                'lack versionCode'));
            return;
        }
        $sqlData['version_code'] = $version_code;
        $result = SqlManager::checkUpdate($sqlData);
        $this->returnData($this->convertReturnJsonSucessed($result));
    }

    /**
     * http://localhost/thinkphp/Sample_Mjmz/Api/getBanner
     * 获取Banner数据
     */
    public function getBanner() {
        $result = SqlManager::getBanner();
        $this->returnData($this->convertReturnJsonSucessed($result));
    }
}