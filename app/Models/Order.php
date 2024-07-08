<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Order extends Model
{
    /**
     * 与模型关联的数据表。
     *
     * @var string
     */
    protected $table = 'li_order';

    /**
     * 该模型是否被自动维护时间戳
     *
     * @var bool
     */
    //public $timestamps = false;

    protected $fillable = [
        'trade_no',
        'name',
        'title',
        'old_price',
        'price',
        'num',

        'num_unit',
        'main_img',
        'brand_id',
        'cat_id',
        'sub_cat_id',
        'attr_id',

        'tag_id',
        'content',
        'is_new',
        'spu_id',
        'user_id',
        'mem_id',

        'act_id',
        'invite_id',
        'order_status',
        'pay_status',
        'express_status',
        'evaluate_status',
        'point_status',

        'addr_id',
        'pay_type',
        'pay_at',
        'express_type',
        'issue_invoice',
    ];

    /**
     * The attributes that should be hidden for arrays.
     *
     * @var array
     */
    protected $hidden = [
        'deleted_at'
    ];

    /**
     * 
     */
    public function sku()
    {
        return $this->hasOne('App\Models\Sku', 'spu_id');
    }

    /**
     * 
     */
    public function addr()
    {
        return $this->belongsTo('App\Models\Addr');
        return $this->hasOne('App\Models\Addr', 'id', 'addr_id');
    }
}
