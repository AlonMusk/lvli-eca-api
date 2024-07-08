<?php

namespace App\Http\Controllers\Admin\Product;

use App\Http\Controllers\Controller;
use App\Exceptions\Code;
use App\Exceptions\Msg;
use App\Service\Admin\ProductService;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use App\Validators\ApiValidator;
use Illuminate\Auth\Events\Failed;

use App\Models\Param;
use App\Models\ParamValue;
use App\Models\Product;

class ParamController extends Controller
{
    protected $productService;

    /**
     * Create a new controller instance.
     *
     * @return void
     */
    public function __construct(ProductService $productService)
    {
        $this->productService = $productService;
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


        $query = Param::orderBy('created_at', 'desc');

        if ($request->name) {
            $query = $query->where('name', 'like', '%' . $request->name . '%');
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

        if (empty($dealResult)) {
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
            'name' => 'required|unique:li_param',
        ]))) {
            return resp([], $validatedData, Code::Failed);
        }
        $data = request()->all();

        // 表单验证
        $model = new Param;

        $model->fill($data);
        $outFormat = $model->save();

        return resp($outFormat);
    }

    public function edit(Request $request)
    {
        if (!empty($validatedData = ApiValidator::validate($request->all(), [
            'id' => 'required'
        ]))) {
            return resp([], $validatedData, Code::Failed);
        }

        try {

            $model = Param::find($request->id);
            if (!$model) {
                return resp([], '该数据不存在', Code::Failed);
            }

            $data = $request->all();

            if (!empty($data['name'])) {
                if ($model->name != $request->name) {
                    $exists = Param::where(['name' => $request->name])->first();
                    if ($exists) {
                        return resp([], '已重名', Code::Failed);
                    }
                }
            }

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
        $dealResult = Param::find($request->id);
        $outFormat = $dealResult;
        return resp($outFormat);
    }

    public function del(Request $request)
    {
        if (!empty($validatedData = ApiValidator::validate($request->all(), [
            'id' => 'required',

        ]))) {
            return resp([], $validatedData, Code::Failed);
        }

        try {

            $model = Param::find($request->id);
            if (!$model) {
                return resp([], '该数据不存在', Code::Failed);
            }
            $exists = ParamValue::where('param_id', $request->id)

                ->exists();

            if ($exists) {
                return resp([], '该数据已使用，不可以删除', Code::Failed);
            }
            $model->delete();
        } catch (\Exception $e) {
            return resp([], $e->getMessage(), Code::Failed);
        }

        $outFormat = [];

        return resp($outFormat);
    }
}
