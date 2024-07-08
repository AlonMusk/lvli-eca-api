<?php

namespace App\Http\Controllers\Admin\Product;

use App\Http\Controllers\Controller;
use App\Exceptions\Code;
use App\Exceptions\Msg;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use App\Validators\ApiValidator;
use Illuminate\Auth\Events\Failed;

use App\Models\MemberSku;

class MemberSkuController extends Controller
{
   

    /**
     * Create a new controller instance.
     *
     * @return void
     */
    public function __construct()
    {
       
    }


    public function list(Request $request)
    {
        $current_page = $request->current_page ?? 1;
       
        $conditions = [
            ['column1', '=', 'value1'],
            ['column2', 'like', '%value2%'],
        ];
        //$request->name && $where['name'] = $request->name;

        $limit =  $request->page_size ?? 10;


        $query = MemberSku::orderBy('created_at', 'desc');

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

        $outFormat = [
            'items' => $dealResult,
            'total' => $total,
            'page_size' => $limit,
            'current_page' => $current_page
        ];

        return resp($outFormat);
    }

    public function add(Request $request)
    {
        if (!empty($validatedData = ApiValidator::validate($request->all(), [

            'spu_id' => 'required',
            'card_id' => 'required',

        ]))) {
            return resp([], $validatedData, Code::Failed);
        }
        $data = request()->all();
        // 表单验证
        $model = new MemberSku;

        $model->fill($data);
        $outFormat = $model->save();

        return resp($outFormat);
    }

    public function edit(Request $request)
    {
        if (!empty($validatedData = ApiValidator::validate($request->all(), [
            'id' => 'required',
            'spu_id' => 'required',
            'card_id' => 'required',

        ]))) {
            return resp([], $validatedData, Code::Failed);
        }

        try {

            $model = MemberSku::find($request->id);
            if(!$model){
                return resp([], '该数据不存在', Code::Failed);
            }
            $data = $request->all();
            $model->fill($data);

            $dealResult =  $model->save();
        } catch (\Exception $e) {
            return resp([], $e->getMessage(), Code::Failed);
        }

        $outFormat = $dealResult;

        return resp($outFormat);
    }

    public function detail(Request $request)
    {
        $dealResult = MemberSku::find($request->id);
        $outFormat = $dealResult;
        return resp($outFormat);
    }
}
