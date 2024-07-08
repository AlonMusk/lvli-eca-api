<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Sku extends Model
{
    /**
     * 与模型关联的数据表。
     *
     * @var string
     */
    protected $table = 'li_sku';

     /**
     * 该模型是否被自动维护时间戳
     *
     * @var bool
     */
    //public $timestamps = false;

    protected $fillable = [
        'trade_no', 
       'spu_id',
        'name', 
        'title', 
        'old_price',

        'price', 
        'volume', 
        'volume_unit',
        'num', 
        'num_unit', 
        'attr_id',
        'tag_id',
        'content',
        'is_new', 
        'status', 
   



    ];

}