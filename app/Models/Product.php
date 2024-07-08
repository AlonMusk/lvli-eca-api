<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Product extends Model
{
    /**
     * 与模型关联的数据表。
     *
     * @var string
     */
    protected $table = 'li_product';

    /**
     * 该模型是否被自动维护时间戳
     *
     * @var bool
     */
    //public $timestamps = false;

    protected $fillable = [
        'trade_no',

        'name',
        'title',
        'main_img',
        'sub_img',
        'brand_id',
        'cat_id',
        'sub_cat_id',
        'attr_id',
        'param_id',
        'tag_id',
        'content',
        'is_new',
        'status',
    ];

    /**
     * 
     */
    public function sku()
    {
        return $this->hasMany('App\Models\Sku', 'spu_id');
    }
}
