<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class ParamValue extends Model
{
    /**
     * 与模型关联的数据表。
     *
     * @var string
     */
    protected $table = 'li_param_value';

    /**
     * 该模型是否被自动维护时间戳
     *
     * @var bool
     */
    //public $timestamps = false;

    protected $fillable = [
        'spu_id', 'param_id', 'content'
    ];

    /**
     * The attributes that should be hidden for arrays.
     *
     * @var array
     */
    protected $hidden = [
        'deleted_at'
    ];
}
