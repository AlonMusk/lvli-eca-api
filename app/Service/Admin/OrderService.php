<?php

namespace App\Service\Admin;

use App\Models\Order;
use App\Models\OrderRefund;
use App\Service\BaseService;
use Illuminate\Support\Facades\Redis;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Storage;

use App\Models\Sku;
use EasyWeChat\Payment\Application as WechatPaymentApp;

class OrderService extends BaseService
{


    public function edit($paramFormat)
    {

        $skuFormat = $paramFormat['sku'][0];
        unset($paramFormat['sku']);
        // 获取 Redis 连接
        $redis = Redis::connection();

        // 定义锁的唯一标识

        $lockKey = genRedisPrefix() . 'order_insert_lock' . $paramFormat['name'];

        // 尝试获取锁
        $lockAcquired = $redis->setnx($lockKey, 1);

        // 如果获取锁成功
        if ($lockAcquired) {

            // 设置锁的过期时间（可选）
            $redis->expire($lockKey, 60);

            try {
                // 开启数据库事务
                DB::beginTransaction();

                // 在事务中执行要插入的逻辑
                $model = Order::find($paramFormat['id']);
                if (!$model) {
                    throw new \Exception('该数据不存在');
                }

                $model->fill($paramFormat);

                $dealResult =  $model->save();

                $skuModel = Sku::find($skuFormat['id']);
                if (!$skuModel) {
                    $skuModel = new Sku();
                }
                unset($skuFormat['id']);
                $skuFormat['trade_no'] =  genTradeNo();;
                $skuFormat['spu_id'] = $model->id;

                $skuModel->fill($skuFormat);
                $dealResult =  $skuModel->save();


                // 提交事务
                DB::commit();
            } catch (\Exception $e) {
                // 插入失败，回滚事务
                DB::rollBack();

                // 可以根据需要进行异常处理，例如记录日志或抛出异常
                throw $e;
            } finally {
                // 释放锁
                $redis->del($lockKey);
            }
        } else {
            // 没有获取到锁，等待一段时间后重试或者抛出异常
            throw new \Exception('请稍后再重试');
        }
    }

    public function refund($request)
    {

        // 获取 Redis 连接
        $redis = Redis::connection();

        // 定义锁的唯一标识
        $lockKey = genRedisPrefix() . 'order_insert_lock' .  $request->order_no;

        // 尝试获取锁
        $lockAcquired = $redis->setnx($lockKey, 1);

        // 如果获取锁成功
        if ($lockAcquired) {

            // 设置锁的过期时间（可选）
            $redis->expire($lockKey, 60);

            try {
                // 开启数据库事务
                DB::beginTransaction();

                // 在事务中执行要插入的逻辑
                $model = Order::find($request->order_no);
                if (!$model) {
                    throw new \Exception('该数据不存在');
                }
                if (1 != $model->pay_status) {
                    throw new \Exception('该订单不满足退款条件');
                }

                // 订单号和退款金额通常从请求中获取
                $orderNo = $request->order_no;
                $refundAmount = $request->refund_amount;

                // 实例化小程序支付
                $wechatPayment = new WechatPaymentApp(config('services.wechat.payment'));

                //$refundNumber = 'refund_' . uniqid(); // 生成唯一的退款单号

                $refundNumber = genTradeNo();

                $result = $wechatPayment->refund->byOutTradeNumber($orderNo, $refundNumber, $refundAmount, $refundAmount, [
                    // 可选的其它配置
                    'refund_desc' => '商品已退货', // 退款原因
                    'notify_url' => env('WECHAT_REFUND_NOTIFY_URL', ''),
                ]);

                if ($result['return_code'] === 'SUCCESS' && $result['result_code'] === 'SUCCESS') {
                    // 退款发起成功
                    // 更新订单状态等操作
                    $model = new OrderRefund();
                    $order = Order::where(['trade_no' => $request->order_no])->first();
                    $data = $order->toArray();
                    unset($data['created_at']);
                    unset($data['updated_at']);
                    $data['trade_no'] = genTradeNo();
                    $data['order_id'] = $order->id;
                    $data['refund_amount'] = $request->refund_amount;
                    $model->fill($data);
                    $outFormat = $model->save();

                    $order->pay_status = 2;
                    $outFormat = $order->save();
                } else {
                    // 退款失败，记录日志或者进行错误处理
                }

                return response()->json($result); // 或者根据需要返回特定的信息


                // 提交事务
                DB::commit();

                return true;
            } catch (\Exception $e) {
                // 插入失败，回滚事务
                DB::rollBack();

                // 可以根据需要进行异常处理，例如记录日志或抛出异常
                throw $e;
            } finally {
                // 释放锁
                $redis->del($lockKey);
            }
        } else {
            // 没有获取到锁，等待一段时间后重试或者抛出异常
            throw new \Exception('请稍后再重试');
        }
    }
}
