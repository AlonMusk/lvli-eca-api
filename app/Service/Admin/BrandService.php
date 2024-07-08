<?php
namespace App\Service\Admin;

use App\Service\BaseService;
use Illuminate\Support\Facades\Redis;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Storage;


class BrandService extends BaseService{
  
    /**
     * 新增
     *
     * @return void
     */
    public function add($paramFormat)
    {

       $res= DB::table('li_brand')->insert($paramFormat);
         
       return $res;

    }

    public function edit($paramFormat)
    {
        $affected = DB::update('update users set votes = 100 where name = ?', ['John']);

       return $affected;

    }
        /**
     * 
     *
     * @return void
     */
    public function list($paramFormat)
    {
      
        $list = DB::table('li_product')->limit(10)->get();
        return $list;
    }


}

