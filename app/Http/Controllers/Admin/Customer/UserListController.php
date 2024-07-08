<?php

namespace App\Http\Controllers\Admin\Customer;

use App\Http\Controllers\Controller;
use Illuminate\Foundation\Auth\AuthenticatesUsers;
use App\Exceptions\Code;
use App\Exceptions\Msg;
use App\Models\MiniUser;
use App\Validators\ApiValidator;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;

class UserListController extends Controller
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


        $query = MiniUser::orderBy('created_at', 'desc');

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
            'username' => 'required',
            'password' => 'required',
        ]))) {
            return resp([], $validatedData, Code::Failed);
        }

        $data = request()->all();


        $model2 = MiniUser::where(['username' => $data['username']])->first();
        if ($model2) {

            return resp([], '已有相同用户名', Code::Failed);
        }


        $data['trade_no'] = genTradeNo();
        $data['password'] = Hash::make($data['password']);
        // 表单验证
        $model = new MiniUser();

        $model->fill($data);
        $model->save();
        $outFormat['id'] = $model->id;
        return resp($outFormat);
    }

    public function edit(Request $request)
    {
        if (!empty($validatedData = ApiValidator::validate($request->all(), [
            'id' => 'required',
            'username' => 'required',
            // 'password' => 'required',
        ]))) {
            return resp([], $validatedData, Code::Failed);
        }

        try {

            $model = MiniUser::find($request->id);
            if (!$model) {
                return resp([], '该数据不存在', Code::Failed);
            }

            $data = $request->all();

            if ($model->username != $data['username']) {
                $model2 = MiniUser::where(['username' => $data['username']])->first();
                if ($model2) {

                    return resp([], '已有相同用户名', Code::Failed);
                }
            }

            !empty($data['password']) && $data['password'] = Hash::make($data['password']);
            $model->fill($data);

            $dealResult =  $model->save();
        } catch (\Exception $e) {
            return resp([], $e->getMessage(), Code::Failed);
        }

        // $outFormat = $dealResult;
        $outFormat['id'] = $model->id;

        return resp($outFormat);
    }

    public function detail(Request $request)
    {
        $dealResult = MiniUser::find($request->id);
        $outFormat = $dealResult;
        return resp($outFormat);
    }
}
