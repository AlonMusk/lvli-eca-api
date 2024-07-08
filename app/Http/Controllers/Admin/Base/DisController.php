<?php

namespace App\Http\Controllers\Admin\Base;

use App\Http\Controllers\Controller;
use App\Exceptions\Code;
use App\Exceptions\Msg;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use App\Validators\ApiValidator;
use Illuminate\Auth\Events\Failed;

use App\Models\Dis;
use Carbon\Carbon;

class DisController extends Controller
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


        $query = Dis::orderBy('created_at', 'desc');

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
            'user_id' => 'required',
            // 'title' => 'required|unique:posts|max:255',
            'fid' => 'required',
            'cid'=>'required',
            'level'=>'required',
            'start_at'=>'required',
            'type'=>'required',
        ]))) {
            return resp([], $validatedData, Code::Failed);
        }
        $data = request()->all();
       

        //$timestamp = Carbon::now(); // 获取当前时间戳
       // $data['trade_no'] = genTradeNo();
        
        // 表单验证
        $model = new Dis;

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

            $model = Dis::find($request->id);
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
        $dealResult = Dis::find($request->id);
        $outFormat = $dealResult;
        return resp($outFormat);
    }
}
