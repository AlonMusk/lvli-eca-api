<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class MemberSku extends Model
{
    /**
     * 与模型关联的数据表。
     *
     * @var string
     */
    protected $table = 'li_mem_sku';

     /**
     * 该模型是否被自动维护时间戳
     *
     * @var bool
     */
    //public $timestamps = false;

    protected $fillable = [
        'spu_id', 
        'sku_id', 

        'card_id',
        'tag_id', 



    ];

}