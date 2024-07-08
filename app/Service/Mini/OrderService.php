<?php
namespace App\Service\Mini;

use App\Models\Order;
use App\Service\BaseService;
use Illuminate\Support\Facades\Redis;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Storage;

use App\Models\Product; 
use App\Models\Sku; 
class OrderService extends BaseService{
  
    /**
     * 新增产品
     *
     * @return void
     */
    public function add($paramFormat)
    {
        $skuFormat = $paramFormat['sku'][0];
        unset($paramFormat['sku']);
      
        // 获取 Redis 连接
        $redis = Redis::connection();
        
        // 定义锁的唯一标识
        $lockKey = genRedisPrefix().'product_insert_lock'.$paramFormat['name'];
      
        // 尝试获取锁
        $lockAcquired = $redis->setnx($lockKey, 1);
        
        // 如果获取锁成功
        if ($lockAcquired) {
            //Storage::disk("aliyun")->append("dir/path/file.txt", "Append Text");
            // 设置锁的过期时间（可选）
            $redis->expire($lockKey, 60);
        
            try {
                // 开启数据库事务
                DB::beginTransaction();
                
                // 在事务中执行要插入的逻辑
             
              
            $model1 = new Product();
            $model1->fill( $paramFormat);
            $outFormat = $model1->save();
    
            $model = Sku::find($skuFormat['id']);
            if(!$model){
                $model = new Sku();
            }
            $skuFormat['trade_no'] =  genTradeNo();;
            $skuFormat['spu_id'] = $model1->id;
            
            $model->fill($skuFormat);
            $dealResult =  $model->save();
        
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

    public function edit($paramFormat)
    {
       
        // 获取 Redis 连接
        $redis = Redis::connection();
        
        // 定义锁的唯一标识
        $lockKey = genRedisPrefix().'order_mini_insert_lock'.$paramFormat['id'];
        
        // 尝试获取锁
        $lockAcquired = $redis->setnx($lockKey, 1);
        
        // 如果获取锁成功
        if ($lockAcquired) {
            
            //Storage::disk("aliyun")->append("dir/path/file.txt", "Append Text");
            // 设置锁的过期时间（可选）
            $redis->expire($lockKey, 60);
        
            try {
                // 开启数据库事务
                DB::beginTransaction();
                
                // 在事务中执行要插入的逻辑
                $model = Order::find($paramFormat['id']);
                if(!$model){
                    throw new \Exception('该数据不存在');
                 
                }
           
                $model->fill($paramFormat);
    
                $dealResult =  $model->save();

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
        /**
     * 
     *
     * @return void
     */
    public function list($paramFormat)
    {
      
        $list = DB::table('li_product')->limit(10)->get();
        return $list;
    }


}

