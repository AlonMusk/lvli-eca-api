<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class MemberCardRule extends Model
{
    /**
     * 与模型关联的数据表。
     *
     * @var string
     */
    protected $table = 'li_member_card_rule';

     /**
     * 该模型是否被自动维护时间戳
     *
     * @var bool
     */
    //public $timestamps = false;

    protected $fillable = [
        'name', 
        'card_id', 

        'behavior',
        'type', 
        'num', 

        'unit',
        'rate', 
      'note',



    ];

}