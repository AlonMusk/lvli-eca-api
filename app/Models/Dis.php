<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Dis extends Model
{
    /**
     * 与模型关联的数据表。
     * distribution
     * @var string 
     */
    protected $table = 'li_dis';

     /**
     * 该模型是否被自动维护时间戳
     *
     * @var bool
     */
    //public $timestamps = false;

    protected $fillable = [
        'fid',
        'cid', 
        'level', 
        'start_at',
        'type',
  
    ];

}