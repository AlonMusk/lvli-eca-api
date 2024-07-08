<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Addr extends Model
{
    /**
     * 与模型关联的数据表。
     *
     * @var string
     */
    protected $table = 'li_user_addr';

    /**
     * 该模型是否被自动维护时间戳
     *
     * @var bool
     */
    //public $timestamps = false;

    protected $fillable = [
        'trade_no',
        'user_id',
        'name',
        'phone',
        'province_id',
        'city_id',
        'region_id',
        'content',
        'is_default',
        'status'
    ];
}
