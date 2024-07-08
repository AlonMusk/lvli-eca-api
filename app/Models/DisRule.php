<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class DisRule extends Model
{
    /**
     * 与模型关联的数据表。
     *
     * @var string
     */
    protected $table = 'li_dis_rule';

     /**
     * 该模型是否被自动维护时间戳
     *
     * @var bool
     */
    //public $timestamps = false;

    protected $fillable = [
        'trade_no',
        'name', 
        'dis_id', 
        'num',
        'unit',

        'return_num',
        'return_unit', 
        'can_union', 
        'start_at',
        'end_at',
        'status',
    ];

}