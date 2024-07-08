<?php

namespace App\Service\Admin;

use App\Service\BaseService;
use App\Models\AdminUser as User;
use function EasyWeChat\Kernel\Support\generate_sign;
use Illuminate\Support\Facades\Log;
use Illuminate\Http\Request;
use App\Models\Order;
use App\Models\OrderRefund;

use EasyWeChat\Pay\Application;

class PcPayService extends BaseService
{
    public function getConfig()
    {
        return [
            //'app_id'             => env('WECHAT_PAYMENT_APPID', ''),
            
           
            'mch_id'             => env('WECHAT_PAYMENT_MCH_ID', 'your-mch-id'),

            // 商户证书
            'private_key'           => env('WECHAT_PAYMENT_KEY_PATH', 'path/to/cert/apiclient_key.pem'),      // XXX: 绝对路径！！！！
            'certificate'          => env('WECHAT_PAYMENT_CERT_PATH', 'path/to/cert/apiclient_cert.pem'),    // XXX: 绝对路径！！！！
            // v3 API 秘钥
            'secret_key'                => env('WECHAT_PAYMENT_KEY3', 'key-for-signature'),
            // v2 API 秘钥
            'v2_secret_key'                => env('WECHAT_PAYMENT_KEY', 'key-for-signature'),

            // 平台证书：微信支付 APIv3 平台证书，需要使用工具下载
            // 下载工具：https://github.com/wechatpay-apiv3/CertificateDownloader
            'platform_certs' => [
                env('WECHAT_PAYMENT_PLATFORM_CERT_PATH', ''),
                // 请使用绝对路径
                // '/path/to/wechatpay/cert.pem',
            ],

            /**
             * 接口请求相关配置，超时时间等，具体可用参数请参考：
             * https://github.com/symfony/symfony/blob/5.3/src/Symfony/Contracts/HttpClient/HttpClientInterface.php
             */
            'http' => [
                'throw'  => true, // 状态码非 200、300 时是否抛出异常，默认为开启
                'timeout' => 5.0,
                // 'base_uri' => 'https://api.mch.weixin.qq.com/', // 如果你在国外想要覆盖默认的 url 的时候才使用，根据不同的模块配置不同的 uri
            ],
             'notify_url'         => env('WECHAT_REFUND_NOTIFY_URL','http://example.com/payments/wechat-notify'),                           // 默认支付结果通知地址

        ];
    }

    
        public function refund(User $user, Request $request)
        {
            //$this->wxpay = app('easywechat.payment');
    
        
    
    
            // 订单号和退款金额通常从请求中获取
            $tradeNo = $request->trade_no;
            $refundAmount = $request->refund_amount;
            $refundNumber = genTradeNo();
       $param= [
            'mch_id'             => env('WECHAT_PAYMENT_MCH_ID', 'your-mch-id'),
           "transaction_id"=> $tradeNo,
            "out_trade_no" => $tradeNo,
            "out_refund_no" =>  $refundNumber,
          //  "reason"=> "退款",
           // "notify_url" => env('WECHAT_REFUND_NOTIFY_URL', ''),
          // "funds_account"=>"AVAILABLE",
            "amount" => [
                "refund" => $refundAmount,
              
                'total' => $refundAmount,
                'currency' => 'CNY',
            ],
            // "goods_detail"=>[
            //     "merchant_goods_id"=> "1217752501201407033233368018",
            //    // "wechatpay_goods_id"=> "1001",
            //     "goods_name"=> "1元购",
            //     "unit_price"=> 100,
            //     "refund_amount"=> 100,
            //     "refund_quantity"=> 1
            // ]
        ]    ;
        $url = "https://api.mch.weixin.qq.com/v3/refund/domestic/refunds";
        $url_parts = parse_url($url);
        $canonical_url = ($url_parts['path'] . (!empty($url_parts['query']) ? "?${url_parts['query']}" : ""));
        $timeStamp = time();
        $noncestr = $this->nonce_str();
        // var_dump($param);
        //$params['mch_id']=$param['mch_id'];//子商户的商户号---商品对应的门店
        $params['out_trade_no'] = $param['out_trade_no'];//支付回调时候获取到的
        $params['out_refund_no'] = $param['out_refund_no'];//自定义
         $params['notify_url'] = env('WECHAT_REFUND_NOTIFY_URL', '');
        $params['amount']['refund'] = intval($param['amount']['refund']);//退款金额
        $params['amount']['total'] = intval($param['amount']['total']);//订单总额
        // $params['amount']['refund'] = 1;//退款金额
        // $params['amount']['total'] = 1;
        $params['amount']['currency'] = 'CNY';
        $json = json_encode($params);
        // var_dump($json);
        $key = $this->getSign_v3($json, $canonical_url, $noncestr, $timeStamp);//签名
        $mchid = $param['mch_id'];//商户ID
        $serial_no = env('WECHAT_SERIAL_NO');//证书序列号
        $token = sprintf('mchid="%s",nonce_str="%s",signature="%s",timestamp="%d",serial_no="%s"',
            $mchid, $noncestr, $key, $timeStamp, $serial_no);
            // var_dump($token);
        $header = array(
            'Content-Type:' . 'application/json; charset=UTF-8',
            'Accept:application/json',
            'User-Agent:*/*',
            'Authorization: WECHATPAY2-SHA256-RSA2048 '.$token
        );
        // var_dump($header);
        $result = $this->curl_post_https($url,$json,$header);
        // var_dump($result);
        // \Think\Log::write('wxrefunds '.$result);
        return $result;
    
        }
        public function getSign_v3($data, $url, $randstr, $time)
        {
            $str = "POST" . "\n" . $url . "\n" . $time . "\n" . $randstr . "\n" . $data . "\n";
            $path = env('WECHAT_PAYMENT_KEY_PATH', 'path/to/cert/apiclient_key.pem');
            $key = file_get_contents($path);//在子商户平台下载的秘钥文件--
            $str = $this->getSha256WithRSA($str, $key);
            return $str;
        }
        public function getSha256WithRSA($content, $privateKey)
        {
            $binary_signature = "";
            $algo = "SHA256";
            openssl_sign($content, $binary_signature, $privateKey, $algo);
            $sign = base64_encode($binary_signature);
            return $sign;
        }
        public  function curl_post_https($url, $data, $header)
        { // 模拟提交数据函数
            $curl = curl_init();
            curl_setopt($curl, CURLOPT_URL, $url);
            curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, 0);
            curl_setopt($curl, CURLOPT_SSL_VERIFYHOST, 2);
            curl_setopt($curl, CURLOPT_USERAGENT, $_SERVER['HTTP_USER_AGENT']);
            curl_setopt($curl, CURLOPT_FOLLOWLOCATION, 1);
            curl_setopt($curl, CURLOPT_AUTOREFERER, 1);
            curl_setopt($curl, CURLOPT_POST, 1);
            curl_setopt($curl, CURLOPT_POSTFIELDS, $data);
            curl_setopt($curl, CURLOPT_TIMEOUT, 30);
            curl_setopt($curl, CURLOPT_HEADER, 0);
            curl_setopt($curl, CURLOPT_RETURNTRANSFER, 1);
     
            curl_setopt($curl, CURLOPT_HTTPHEADER, $header);
            $result = curl_exec($curl);
            if (curl_errno($curl)) {
                $error = curl_error($curl);
                Log::write('curl_post_https-'.$error);
            }
            curl_close($curl);
            return $result;
        }
      function nonce_str(){
            $result = '';
            $str = 'QWERTYUIOPASDFGHJKLZXVBNMqwertyuioplkjhgfdsamnbvcxz';
            for ($i=0;$i<32;$i++){
                $result .= $str[rand(0,48)];
            }
            return $result;
        }
    

    public function refund1(User $user, Request $request)
    {
        //$this->wxpay = app('easywechat.payment');

        $config = $this->getConfig();
        $app = new Application($this->getConfig());


        // 订单号和退款金额通常从请求中获取
        $tradeNo = $request->trade_no;
        $refundAmount = $request->refund_amount;
        $refundNumber = genTradeNo();

        $order = [
            'out_trade_no' =>  $tradeNo,
            'out_refund_no' => $refundNumber,
            'amount' => [
                'refund' => $refundAmount,
                'total' => $refundAmount,
                'currency' => 'CNY',
            ],
        ];

        $api = $app->getClient();

        try{
            
            $result  = $api->post('/v3/refund/domestic/refunds', [
                'json' => [
                    'sub_mch_id'             => env('WECHAT_PAYMENT_MCH_ID', 'your-mch-id'),
                   "transaction_id"=> $tradeNo,
                    "out_trade_no" => $tradeNo,
                    "out_refund_no" =>  $refundNumber,
                  //  "reason"=> "退款",
                   // "notify_url" => env('WECHAT_REFUND_NOTIFY_URL', ''),
                  // "funds_account"=>"AVAILABLE",
                    "amount" => [
                        "refund" => $refundAmount,
                      
                        'total' => $refundAmount,
                        'currency' => 'CNY',
                    ],
                    // "goods_detail"=>[
                    //     "merchant_goods_id"=> "1217752501201407033233368018",
                    //    // "wechatpay_goods_id"=> "1001",
                    //     "goods_name"=> "1元购",
                    //     "unit_price"=> 100,
                    //     "refund_amount"=> 100,
                    //     "refund_quantity"=> 1
                    // ]
                ]
            ])->toArray();
        } catch (ServerException $err) {
            return json_decode($err->getResponse()->getContent(false), true);
        } catch (ClientException $err) {
            return json_decode($err->getResponse()->getContent(false), true);
        } catch (\Throwable $err) {
            return $err->getMessage();
        }
        return  $result;
       
        //$result = $response->toArray();
        Log::info($result);
      //  $app = []; //Factory::payment($this->getConfig());
       // $result = $app->refund->byOutTradeNumber($tradeNo, $refundNumber, $refundAmount, $refundAmount, [
            // 可选的其它配置
          //  'refund_desc' => '商品已退货', // 退款原因
            //'notify_url' => env('WECHAT_REFUND_NOTIFY_URL', ''),
       // ]);

        // $result = $this->wxpay->refund->byOutTradeNumber($tradeNo, $refundNumber, $refundAmount, $refundAmount, [
        //     // 可选的其它配置
        //     'refund_desc' => '商品已退货', // 退款原因
        //     'notify_url' => env('WECHAT_REFUND_NOTIFY_URL', ''),
        // ]);

        if ($result['return_code'] === 'SUCCESS' && $result['result_code'] === 'SUCCESS') {
            // 退款发起成功
            // 更新订单状态等操作
            $model = new OrderRefund();
            $order = Order::where(['trade_no' => $request->trade_no])->first();
            $data = $order->toArray();
            unset($data['created_at']);
            unset($data['updated_at']);
            $data['trade_no'] = genTradeNo();
            $data['order_no'] = $order->trade_no;
            $data['admin_id'] = $user->id;
            $data['refund_amount'] = $request->refund_amount;
            $model->fill($data);
            $outFormat = $model->save();

            $order->pay_status = 2;
            $outFormat = $order->save();
        } else {
            // 退款失败，记录日志或者进行错误处理
        }

        return $result;
    }


    //退款回调
    public function refundCallback()
    {
        $config = $this->getConfig();
        $app = new Application($this->getConfig());

        $server = $app->getServer();
        $server->handleRefunded(function ( $message, \Closure $next) {
            // $message->out_trade_no 获取商户订单号
            // $message->payer['openid'] 获取支付者 openid

            $order = Order::where('trade_no', $message->out_trade_no)->first();

            if (!$order || $order->pay_status == '3') { // 如果订单不存在 或者 订单已经退过款了
                return true; // 告诉微信，我已经处理完了，订单没找到，别再通知我了
            }
            $order->pay_status = 3;
            $order->save();

            return $next($message);
        });
        
        // 默认返回 ['code' => 'SUCCESS', 'message' => '成功']
        return $server->serve();

      


        //$this->wxpay = app('easywechat.payment');
        // $app = Factory::payment($this->getConfig());
        // $response = $app->handleRefundedNotify(function ($message, $reqInfo, $fail) {
        //     // return $this->wxpay->handleRefundedNotify(function ($message, $reqInfo, $fail) {
        //     // 其中 $message['req_info'] 获取到的是加密信息
        //     // $reqInfo 为 message['req_info'] 解密后的信息

        //     $order = Order::where('trade_no', $reqInfo['out_trade_no'])->first();

        //     if (!$order || $order->pay_status == '3') { // 如果订单不存在 或者 订单已经退过款了
        //         return true; // 告诉微信，我已经处理完了，订单没找到，别再通知我了
        //     }
        //     if ($message['return_code'] == 'SUCCESS') {
        //         $update_data = [];
        //         if ($reqInfo['refund_status'] == 'SUCCESS') {
        //             $order->pay_status = 3;
        //             $order->save();
        //         } else {
        //         }
        //     }
        //     return true; // 返回 true 告诉微信“我已处理完成”
        //     // 或返回错误原因 $fail('参数格式校验错误');
        // });
        // $response->send(); // return $response;
    }
}
