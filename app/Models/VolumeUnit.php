<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class VolumeUnit extends Model
{
    /**
     * 与模型关联的数据表。
     *
     * @var string
     */
    protected $table = 'li_volume_unit';

     /**
     * 该模型是否被自动维护时间戳
     *
     * @var bool
     */
    //public $timestamps = false;

    protected $fillable = [
        'name', 'title', 'content',
    ];

}