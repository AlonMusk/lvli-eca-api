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
use App\Models\Sku;
use App\Models\Product;

class SkuController extends Controller
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


        $query = Sku::orderBy('created_at', 'desc');

        if ($request->spu_id) {
            $query = $query->where('spu_id', '=', $request->spu_id);
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
            'spu_id' => 'required',
            'old_price' => 'required',
            // 'title' => 'required|unique:posts|max:255',
            'price' => 'required',
            'volume' => 'required',

            'volume_unit' => 'required',
            'num' => 'required',
            // 'sub_cat_id',
            'num_unit' => 'required',
            // 'tag_id' => 'required',
            'status' => 'required',

        ]))) {
            return resp([], $validatedData, Code::Failed);
        }

        $outFormat = [];
        $data = $request->all();
        $data['trade_no'] = genTradeNo();
        try {
            $model1 = Product::find($request->spu_id);
            if (!$model1) {
                return resp([], '该产品数据不存在', Code::Failed);
            }

            // 表单验证
            $model = new Sku;

            $model->fill($data);
            $outFormat = $model->save();
        } catch (\Exception $e) {
            return resp([], $e->getMessage(), Code::Failed);
        }



        return resp($outFormat);
    }

    public function edit(Request $request)
    {
        if (!empty($validatedData = ApiValidator::validate($request->all(), [
            'id' => 'required',
            'spu_id' => 'required',
            'old_price' => 'required',
            // 'title' => 'required|unique:posts|max:255',
            'price' => 'required',
            'volume' => 'required',

            'volume_unit' => 'required',
            'num' => 'required',
            // 'sub_cat_id',
            'num_unit' => 'required',
            // 'tag_id' => 'required',
            'status' => 'required',

        ]))) {
            return resp([], $validatedData, Code::Failed);
        }



        $data = $request->all();

        try {
            $model1 = Product::find($request->spu_id);
            if (!$model1) {
                return resp([], '该产品数据不存在', Code::Failed);
            }
            $model = Sku::find($request->id);
            if (!$model) {
                return resp([], '该数据不存在', Code::Failed);
            }
            $data = $request->all();
            $model->fill($data);

            $dealResult =  $model->save();
        } catch (\Exception $e) {
            return resp([], $e->getMessage(), Code::Failed);
        }

        $outFormat = [];

        return resp($outFormat);
    }

    public function detail(Request $request)
    {
        // 获取当前已认证的用户...
        $user = Auth::user();

        // 获取当前已认证的用户 ID...
        $id = Auth::id();

        $users = DB::table('li_user')->get();

        return resp($users);
    }
}
