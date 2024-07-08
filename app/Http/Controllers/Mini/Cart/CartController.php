<?php

namespace App\Http\Controllers\Mini\Order;

use App\Http\Controllers\Controller;
use App\Exceptions\Code;
use App\Exceptions\Msg;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use App\Models\Order;

class CartController extends Controller
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


        $query = Order
            ::with(['sku' => function ($query) {
                //$query->where('content', 'like', 'foo%');
                $query->select(['id', 'spu_id', 'price', 'old_price']); //->where('spu_id', $request->id);
            }])
            ->orderBy('created_at', 'desc');

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
        $detail = Order::find($request->id);
        if (!$detail) {
            return resp([], '数据不存在', Code::Failed);
        }

        $subImgs = [];
        $prefix = env('OSS_ACCESS_URL', 'http://static.lvlics.com');
        if (!empty($detail->sub_img)) {
            $subImgs = explode(',', $detail->sub_img);
            // $subImgs= collect($subImgs)->map(function($item)use($prefix){
            //     $item =  $prefix.$item;
            // })->all();
            $subImgs = array_map(function ($item) use ($prefix) {
                return ['imgUrl' => $prefix . $item];
            }, $subImgs);
        }
        $detail->main_img = $prefix . $detail->main_img;
        $detail->sub_img = $subImgs;

        $sku = $detail->sku()->select(['id', 'spu_id', 'price', 'old_price'])->where('spu_id', $request->id)->get()->toArray();
        $detail = $detail->toArray();
        //  $detail['sku'] = $detail->sku->toArray();
        //dd($detail);
        if (empty($sku)) {
            $sku = [
                [
                    'id' => 0,
                    "spu_id" => $request->id,
                    'price' => '',
                    "old_price" => "",
                    "discount" => ""
                ]
            ];
        } else {
            $sku = array_map(function ($item) {
                $item['discount'] =  intval(($item['price']  / $item['old_price']) * 100) / 10;
                return  $item;
            }, $sku);
        }
        $detail['sku'] = $sku;

        $outFormat = [];
        return resp($detail);
    }
}
