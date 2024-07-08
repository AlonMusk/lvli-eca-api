<?php

namespace App\Http\Controllers\Mini\Order;

use App\Http\Controllers\Controller;
use App\Exceptions\Code;
use App\Exceptions\Msg;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use App\Models\Order;
use App\Service\Mini\OrderService;
use App\Validators\ApiValidator;

class OrderController extends Controller
{
    protected $orderService;

    /**
     * Create a new controller instance.
     *
     * @return void
     */
    public function __construct(OrderService $orderService)
    {
        $this->orderService = $orderService;
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


        $query = Order::where('point_status',1)
            ->with(['sku' => function ($query) {
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

        $addr = ($detail->addr);
        $detail = $detail->toArray();
        $detail['addr'] = $addr;

        return resp($detail);
    }

    public function refund(Request $request)
    {
    
        if (!empty($validatedData = ApiValidator::validate($request->all(), [
            'id' => 'required',
            
        ]))) {
            return resp([], $validatedData, Code::Failed);
        }

        $data = $request->all();
        $data['pay_status'] =2; 

        try {
            $dealResult = $this->orderService->edit($data);
        } catch (\Exception $e) {
            return resp([], $e->getMessage(), Code::Failed);
        }

        $outFormat = [];

        return resp($outFormat);
    }

    public function del(Request $request)
    {
    
        if (!empty($validatedData = ApiValidator::validate($request->all(), [
            'id' => 'required',
            
        ]))) {
            return resp([], $validatedData, Code::Failed);
        }

        $data = $request->all();
        $data['point_status'] =0; 

        try {
            $dealResult = $this->orderService->edit($data);
        } catch (\Exception $e) {
            return resp([], $e->getMessage(), Code::Failed);
        }

        $outFormat = [];

        return resp($outFormat);
    }

}
