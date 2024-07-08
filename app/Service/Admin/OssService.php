<?php

namespace App\Service\Admin;

use App\Service\BaseService;
use Illuminate\Support\Facades\Redis;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Storage;


class OssService extends BaseService
{

    public function OssPolicy()
    {
        $disk = Storage::disk('oss');
        /**
         * 1. 前缀如：'images/'
         * 2. 回调服务器 url
         * 3. 回调自定义参数，oss 回传应用服务器时会带上
         * 4. 当前直传配置链接有效期
         */
        //$config = $disk->signatureConfig($prefix = '/', $callBackUrl = '', $customData = [], $expire = 30);

        $prefix = env('OSS_BUCKET_DIR','outsourcing/');
        $callBackUrl = env('OSS_CALLBACK','');
        $customData = [];
        $expire = 300;
        $config = $disk->signatureConfig($prefix, $callBackUrl, $customData, $expire);

        return $config;
    }

    public function ossVerify()
    {
        $disk = Storage::disk('oss');
        // 验签，就是如此简单
        // $verify 验签结果，$data 回调数据
        list($verify, $data) = $disk->verify();
        // [$verify, $data] = $disk->verify(); // php 7.1 +
        $url  =  env('OSS_ACCESS_URL','');
        if (!$verify) {
            // 验证失败处理，此时 $data 为验签失败提示信息
            $res = ['url'=>$url,'data'=>$data];
        }else{

            $res = ['url'=>$url,'data'=>$data];
        }


// bucket: "lvli-os"
// etag: "6423C537F2297B67DAB2436D1C49CC99"
// filename: "liquor/16962384698622026.jpg"
// format: "jpg"
// height: "1200"
// mimeType: "image/jpeg"
// size: "399929"
// width: "1920"

        return $res;

    }
}
