<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class ActRule extends Model
{
    /**
     * 与模型关联的数据表。
     *
     * @var string
     */
    protected $table = 'li_act_rule';

     /**
     * 该模型是否被自动维护时间戳
     *
     * @var bool
     */
    //public $timestamps = false;

    protected $fillable = [
        'trade_no','act_id', 'num', 'type','start_at',
        'end_at','status',
    ];

}