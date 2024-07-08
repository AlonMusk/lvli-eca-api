<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class MemberCardOrder extends Model
{
    /**
     * 与模型关联的数据表。
     *
     * @var string
     */
    protected $table = 'li_member_card_order';

     /**
     * 该模型是否被自动维护时间戳
     *
     * @var bool
     */
    //public $timestamps = false;

    protected $fillable = [
        'trade_no', 
        'user_id', 

        'card_id',
        'level', 
        'discount', 

        'is_forever',
        'start_at', 
        'end_at', 



    ];

}