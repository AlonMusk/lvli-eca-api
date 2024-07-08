<?php

namespace App\Http\Controllers\Mini\Base;

use App\Http\Controllers\Controller;
use App\Exceptions\Code;
use App\Exceptions\Msg;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use App\Models\Addr;
use App\Validators\ApiValidator;

class AddrController extends Controller
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


        $query = Addr::orderBy('created_at', 'desc');

        if ($request->name) {
            $query = $query->where('name', 'like', '%' . $request->name . '%');
        }

        $offset = ($current_page - 1) * $limit;

        try {
            $total = $query

                ->count();

            $subQuery = $query
                ->offset($offset)
                ->limit($limit);


            //$subQuery->sku =  $subQuery->sku()->select(['id','spu_id','price','old_price'])->where('spu_id', $request->id)->get();
            // dd($subQuery->toSql());
            $dealResult = $subQuery
                ->get()->toArray();
        } catch (\Exception $e) {
            return resp([], $e->getMessage(), Code::Failed);
        }

        if (empty($dealResult)) {
            $current_page = 1;
        }

        $outFormat = [

            'data' => $dealResult,
            'total' => $total,
            'page_size' => $limit,
            'current_page' => $current_page
        ];

        return resp($outFormat);
    }

    public function detail(Request $request)
    {
        $detail = Addr::find($request->id);
        if (!$detail) {
            return resp([], '数据不存在', Code::Failed);
        }

        $detail = $detail->toArray();
        return resp($detail);
    }

    public function add(Request $request)
    {
        if (!empty($validatedData = ApiValidator::validate($request->all(), [
            'name' => 'required',
            'user_id' => 'required',
            'phone' => 'required',
            'province_id' => 'required',
            'city_id' => 'required',
            'region_id' => 'required',
            'content' => 'required',
        ]))) {
            return resp([], $validatedData, Code::Failed);
        }
        $data = request()->all();
        $data['trade_no'] = genTradeNo();
        // 表单验证
        $model = new Addr;

        $model->fill($data);
        $outFormat = $model->save();

        return resp($outFormat);
    }

    public function edit(Request $request)
    {
        if (!empty($validatedData = ApiValidator::validate($request->all(), [

            'name' => 'required',
            'user_id' => 'required',
            'phone' => 'required',
            'province_id' => 'required',
            'city_id' => 'required',
            'region_id' => 'required',
            'content' => 'required',

        ]))) {
            return resp([], $validatedData, Code::Failed);
        }

        try {

            $model = Addr::find($request->id);
            if (!$model) {
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
}
