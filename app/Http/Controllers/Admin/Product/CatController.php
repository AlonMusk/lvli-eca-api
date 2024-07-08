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

use App\Models\Cat;
use App\Models\Product;

class CatController extends Controller
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


        $query = Cat::orderBy('created_at', 'desc');

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
        $newItem = ['id' => 0, 'name' => '未选择'];
        $existingItem = array_filter($dealResult, function ($item) use ($newItem) {
            return $item['id'] === $newItem['id'];
        });

        if (empty($existingItem)) {
            array_push($dealResult, $newItem);
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
            'name' => 'required|unique:li_cat',

            'fid' => 'required',

            'title' => 'required',

        ]))) {
            return resp([], $validatedData, Code::Failed);
        }
        $data = request()->all();
        $data['title'] =  $data['name'];

        $data['level'] = 1;
        if ($data['fid'] > 0) {
            $model1 = Cat::find($data['fid']);
            if (!$model1) {
                return resp([], '父分类数据不存在', Code::Failed);
            }
            $data['level'] = 2;
        }
        // 表单验证
        $model = new Cat;

        $model->fill($data);
        $outFormat = $model->save();

        return resp($outFormat);
    }

    public function edit(Request $request)
    {
        if (!empty($validatedData = ApiValidator::validate($request->all(), [
            'name' => 'required|unique:li_cat',

            'fid' => 'required',

            'title' => 'required',

        ]))) {
            return resp([], $validatedData, Code::Failed);
        }

        try {

            $model = Cat::find($request->id);
            if (!$model) {
                return resp([], '该数据不存在', Code::Failed);
            }
            if ($model->fid != $request->fid) {
                return resp([], '暂时不支持修改父级ID', Code::Failed);
            }
            $data = $request->all();
            $data['title'] =  $data['name'];

            $data['level'] = 1;
            if ($data['fid'] > 0) {
                $data['level'] = 2;
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
        $dealResult = Cat::find($request->id);
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

            $model = Cat::find($request->id);
            if (!$model) {
                return resp([], '该数据不存在', Code::Failed);
            }
            $exists = Product::where('cat_id', $request->id)
                ->orWhere('sub_cat_id', $request->id)
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
