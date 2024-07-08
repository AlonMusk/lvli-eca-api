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
use App\Models\Product;

class ProductController extends Controller
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


        $query = Product::orderBy('created_at', 'desc');

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
            'name' => 'required',
            // 'title' => 'required|unique:posts|max:255',
            'title' => 'required',
            'main_img' => 'required',

            'brand_id' => 'required',
            'cat_id' => 'required',
            // 'sub_cat_id',
            'attr_id' => 'required',
            // 'tag_id' => 'required',
            'content' => 'required',
            'sku' => 'required',
            'is_new' => 'required',
            'status' => 'required',

        ]))) {
            return resp([], $validatedData, Code::Failed);
        }



        $data = $request->all();
        $data['trade_no'] = genTradeNo();
        try {
            $dealResult = $this->productService->add($data);
        } catch (\Exception $e) {
            return resp([], $e->getMessage(), Code::Failed);
        }

        $outFormat = [];

        return resp($outFormat);
    }

    public function edit(Request $request)
    {
        if (!empty($validatedData = ApiValidator::validate($request->all(), [
            'id' => 'required',
            'name' => 'required',
            // 'title' => 'required|unique:posts|max:255',
            'title' => 'required',
            'main_img' => 'required',

            'brand_id' => 'required',
            'cat_id' => 'required',
            // 'sub_cat_id',
            'attr_id' => 'required',
            // 'tag_id' => 'required',
            'content' => 'required',
            'sku' => 'required',
            'is_new' => 'required',
            'status' => 'required',

        ]))) {
            return resp([], $validatedData, Code::Failed);
        }



        $data = $request->all();

        try {
            $dealResult = $this->productService->edit($data);
        } catch (\Exception $e) {
            return resp([], $e->getMessage(), Code::Failed);
        }

        $outFormat = [];

        return resp($outFormat);
    }

    public function detail(Request $request)
    {
        $detail = Product::find($request->id);
        if (!$detail) {
            return resp([], '数据不存在', Code::Failed);
        }

        $sku = $detail->sku()->select(['id','spu_id','price','old_price'])->where('spu_id', $request->id)->get()->toArray();
        $detail = $detail->toArray();
      //  $detail['sku'] = $detail->sku->toArray();
        //dd($detail);
        if(empty( $sku)){
            $sku = [
                [
                    'id'=>0,
                    "spu_id"=>$request->id,
                    'price' =>'',
                    "old_price"=>"",
                ]
            ];
        }
        $detail['sku'] =$sku;
        
        $outFormat = [];
        return resp($detail);
    }
}
