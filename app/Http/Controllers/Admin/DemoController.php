<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Exceptions\Code;
use App\Exceptions\Msg;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class DemoController extends Controller
{

    /**
     * Create a new controller instance.
     *
     * @return void
     */
    public function __construct()
    {
    }


    public function test(Request $request)
    {
        // 获取当前已认证的用户...
        $user = Auth::user();
        // 获取当前已认证的用户 ID...
        $id = Auth::id();
        $users = DB::table('li_user')->get();

        return resp($users);
        //$paramReq 获取 输入请求参数;
        $paramReq = '';
        // paramFormat 格式化调用service的参数
        $paramFormat = [];

        // 扔给service 处理，得到返回结果
        $dealResult = [];
       // $service = new PeerRecallService();
       // $dealResult = $service->dealAddFormDetail();

        // outFormat 格式化输出参数
        $outFormat = [];


        // $outResult 输出结果
        $outResult = [];

        return $outResult;
    }

    public function list(Request $request)
    {

        return resp();
    }

    public function add(Request $request)
    {

        return resp();
    }

    public function edit(Request $request)
    {

        return resp();
    }

    public function detail(Request $request)
    {

        return resp();
    }
}
