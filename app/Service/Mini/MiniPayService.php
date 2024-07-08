<?php

namespace App\Service\Mini;

use App\Service\BaseService;
use App\Models\MiniUser as User;
use Illuminate\Support\Facades\Log;
use Illuminate\Http\Request;
use App\Models\Order;

use EasyWeChat\Pay\Application;

class MiniPayService extends BaseService
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
            // 'notify_url'         => env('WECHAT_PAYMENT_NOTIFY_URL','http://example.com/payments/wechat-notify'),                           // 默认支付结果通知地址

        ];
    }


    public function orderIsExpire($detail)
    {
        $expireTime = 60 * 15;
        if ((time() - $expireTime > strtotime($detail->created_at)) || 2 == $detail->order_status) {
            return true;
        }
        return false;
    }

    /**
     * 发起微信支付
     *
     * @return Array
     */
    public function pay(User $user, Request $request)
    {
        $config = $this->getConfig();
        $app = new Application($this->getConfig());

        $tradeNo  = genTradeNo();
        //先订单入库 必填  trade_no  spu_id name title price main_img num

        $body = $request->name;
        $totalFee = bcmul($request->price, 100);
        if (!empty($request->order_id)) {
            $model = Order::find($request->order_id);
            if (!$model) {
                throw new \Exception('订单数据不存在');
            }
            if (1 == $model->order_status) {
                throw new \Exception('订单已取消');
            }
            if ($this->orderIsExpire($model)) {
                throw new \Exception('订单已过期');
            }
            $body = $model->name;
            $totalFee = bcmul($model->price, 100);
            $tradeNo  = $model->trade_no;
        } else {
            $model = new Order();
            $model->trade_no =  $tradeNo;
            $model->spu_id = $request->spu_id;
            $model->name = $request->name;
            $model->title = $request->title;
            $model->price = $request->price;
            $model->main_img = $request->main_img;
            $model->num = $request->num;
            $model->save();
        }

        //小程序 JSAPI下单
        $api = $app->getClient();
        $response = $api->post('/v3/pay/transactions/jsapi', [
            'json' => [
                "mchid" =>  $config['mch_id'],
                "appid" =>   env('WECHAT_PAYMENT_APPID', ''),
                "out_trade_no" =>  $tradeNo,
                "description" => $body,
                "notify_url" => env('WECHAT_PAYMENT_NOTIFY_URL', ''),
               
                "amount" => [
                   
                    'total' => $request->price,
                    'currency' => 'CNY',
                ],
                "payer" =>[
                    'openid' => $user->openid, 
                ]
            ]
        ]);
        $unify = $response->toArray();

        // 在实例化的时候传入配置即可
        // $app = Factory::miniProgram($this->config);
        // 判断当前是否为沙箱模式：
        //bool $app->inSandbox();

        // $app = []; // Factory::payment($this->getConfig());

        // $unify = $app->order->unify([
        //     'body' => $body,
        //     'out_trade_no' =>  $tradeNo,
        //     'total_fee' => $totalFee,
        //     'trade_type' => 'JSAPI',
        //     'openid' => $user->openid, // 用户的openid
        // ]);


        // $this->wxpay = app('easywechat.payment');

        // $unify = $this->wxpay->order->unify([
        //     'body' => $body,
        //     'out_trade_no' =>  $tradeNo,
        //     'total_fee' => $totalFee,
        //     'trade_type' => 'JSAPI',
        //     'openid' => $user->openid, // 用户的openid
        // ]);
        $appId = env('WECHAT_PAYMENT_APPID', '');
        $signType = 'RSA'; // 默认RSA，v2要传MD5
        $prepayId= $unify['prepay_id'];
        $utils = $app->getUtils();
        $result = $utils->buildMiniAppConfig($prepayId, $appId, $signType);
        return $result;
        
    }

    public function payCallback()
    {
        $config = $this->getConfig();
        $app = new Application($this->getConfig());

        $server = $app->getServer();

       // $app = []; //Factory::payment($this->getConfig());
       $server->handlePaid(function ($message, \Closure $next) {
        // $message->out_trade_no 获取商户订单号
        // $message->payer['openid'] 获取支付者 openid
        // 🚨🚨🚨 注意：推送信息不一定靠谱哈，请务必验证
        // 建议是拿订单号调用微信支付查询接口，以查询到的订单状态为准
    
        $outTradeNo = $message->out_trade_no ;
        $transactionId = $message->transaction_id;
        if ($message->trade_state === 'SUCCESS') {
            // TODO: 你的发货逻辑
            $model = Order::where('trade_no', $message->out_trade_no)->first();
            if ($model) {
                $model->transaction_id =$message->transaction_id;
                $model->pay_status = 1;
                $model->save();
            }
           // return true;
        }
        Log::info($message);
        return $next($message);
    });
    
    // 默认返回 ['code' => 'SUCCESS', 'message' => '成功']
    return $server->serve();


        // $response = $app->handlePaidNotify(
        //     function ($message, $fail) {
        //         // $this->wxpay = app('easywechat.payment');
        //         // return $this->wxpay->handlePaidNotify(function ($message, $fail) {
        //         Log::info($message);

        //         if ($message['result_code'] === 'FAIL') {

        //             return true;
        //         } else if ($message['return_code'] === 'SUCCESS') {

        //             // TODO: 你的发货逻辑
        //             $model = Order::where('trade_no', $message['out_trade_no'])->first();
        //             if ($model) {
        //                 $model->transaction_id = $message['transaction_id'];
        //                 $model->pay_status = 1;
        //                 $model->save();
        //             }


        //             return true;
        //         }
        //     }

        // );

        $response->send(); // return $response;
    }
}
