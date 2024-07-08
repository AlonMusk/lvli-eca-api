<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class ActSpu extends Model
{
    /**
     * 与模型关联的数据表。
     *
     * @var string
     */
    protected $table = 'li_act_spu';

     /**
     * 该模型是否被自动维护时间戳
     *
     * @var bool
     */
    //public $timestamps = false;

    protected $fillable = [
        'trade_no', 
        'act_id', 
        'is_all',
        'brand_id', 
        'cat_id', 
        'spu_id',
       
        'sku_id', 
        'stock', 
        'status',

    ];

}