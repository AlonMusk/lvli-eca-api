<?php

namespace App\Http\Controllers\Mini\Product;

use App\Http\Controllers\Controller;
use App\Exceptions\Code;
use App\Exceptions\Msg;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use App\Validators\ApiValidator;
use Illuminate\Auth\Events\Failed;

use App\Models\Cat;
use App\Models\Product;

class CatController extends Controller
{
   

    /**
     * Create a new controller instance.
     *
     * @return void
     */
    public function __construct()
    {
       
    }


    /**
     * 分类列表
     *
     * @param Request $request
     * @return void
     */
    public function list(Request $request)
    {
        
        $current_page = $request->current_page ?? 1;
       
        $conditions = [
            ['column1', '=', 'value1'],
            ['column2', 'like', '%value2%'],
        ];
        //$request->name && $where['name'] = $request->name;

        $limit =  $request->page_size ?? 10;

        $query = Cat::orderBy('fid', 'asc');

        if($request->name){
            $query = $query->where('name','like','%'.$request->name.'%');
        }
    
        $offset = ($current_page - 1) * $limit;

        try {
            $total = $query->count();
           
            $subQuery = $query
                ->offset($offset)
                ->limit($limit);
               // dd($subQuery->toSql());
                $dealResult = $subQuery
                ->get()->toArray();
        } catch (\Exception $e) {
            return resp([], $e->getMessage(), Code::Failed);
        }

        if(empty($dealResult)){
            $current_page = 1;
        }

        // id:2 最近
        $spuQuery = Product::where('sub_cat_id','>',0);
        $offset = ($current_page - 1) * $limit;
        $spuTotal = $spuQuery->count();
        $subQuery = $spuQuery
        ->select(['id','name','main_img','sub_cat_id'])
        //->groupBy('sub_cat_id')
        ->orderBy('created_at', 'desc')
        ->offset($offset)
        ->limit($limit)
        ;
       // ->pluck('sub_cat_id');
       
        $spuDealResult = $subQuery
        ->get()
        //->keyBy('sub_cat_id')
        //dd($subQuery->toSql());
        ->toArray();
//dd($spuDealResult,$dealResult);
        $fCatList = [];
        $CCatList = [];
        $CCatListData = [];
         $prefix=env('OSS_ACCESS_URL','http://static.lvlics.com');
        foreach($dealResult as $item){
            if($item['fid'] >0){
                foreach($spuDealResult as $spuItem){
                    if($spuItem['sub_cat_id']==$item['id']){
                        
                        $CCatListData[$item['id']][] = [
                            'id'=>$spuItem['id'],
                            'name'=>$spuItem['name'],
                            'imgUrl'=>$prefix.$spuItem['main_img'],
                            'url'=>'/pages/details/details?id='.$spuItem['id']
                        ];
                    }

                }
                
            }
        }
        //dd($CCatListData);
        unset($item);
        foreach($dealResult as $item){
            if($item['fid'] >0){
                $CCatList[$item['fid']][] = [
                    'id'=>$item['id'],
                    'name'=>$item['name'],
                    'list'=>$CCatListData[$item['id']]??[],
                ];
            }
        }
        unset($item);
        foreach($dealResult as $item){
            if($item['fid'] ==0){
                $fCatList[$item['id']] = [
                    'id'=>$item['id'],
                    'name'=>$item['name'],
                    'data'=>$CCatList[$item['id']],
                ];
            }
        }

        $outFormat = [
            'items' => array_values( $fCatList),
            'total' => $total,
            'page_size' => $limit,
            'current_page' => $current_page
        ];

        return resp($outFormat);
    }

    public function add(Request $request)
    {
        if (!empty($validatedData = ApiValidator::validate($request->all(), [
            'name' => 'required|unique:li_act',
            // 'title' => 'required|unique:posts|max:255',
            'title' => 'required',
            'type'=>'required',
        ]))) {
            return resp([], $validatedData, Code::Failed);
        }
        $data = request()->all();
        $data['trade_no'] = genTradeNo();
        // 表单验证
        $model = new Act;

        $model->fill($data);
         $model->save();
         $outFormat['id'] =$model->id;
        return resp( $outFormat);
    }

    public function edit(Request $request)
    {
        if (!empty($validatedData = ApiValidator::validate($request->all(), [
            'id' => 'required',
            'name' => 'required',
            'title' => 'required',

        ]))) {
            return resp([], $validatedData, Code::Failed);
        }

        try {

            $model = Act::find($request->id);
            if(!$model){
                return resp([], '该数据不存在', Code::Failed);
            }
            $data = $request->all();
            $model->fill($data);

            $dealResult =  $model->save();
        } catch (\Exception $e) {
            return resp([], $e->getMessage(), Code::Failed);
        }

       // $outFormat = $dealResult;
        $outFormat['id'] =$model->id;

        return resp($outFormat);
    }

    public function detail(Request $request)
    {
        $dealResult = Act::find($request->id);
        $outFormat = $dealResult;
        return resp($outFormat);
    }
}
