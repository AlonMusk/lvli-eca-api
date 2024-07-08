<?php

namespace App\Http\Controllers\Admin\Base;

use App\Http\Controllers\Controller;
use App\Exceptions\Code;
use App\Exceptions\Msg;
use App\Service\Admin\OssService;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use App\Validators\ApiValidator;
use Illuminate\Auth\Events\Failed;

class OssController extends Controller
{
    protected $ossService;

    /**
     * Create a new controller instance.
     *
     * @return void
     */
    public function __construct(OssService $ossService)
    {
        $this->ossService = $ossService;
    }


    public function ossPolicy(Request $request)
    {

        try {
            $dealResult = $this->ossService->OssPolicy();
            $data = json_decode ($dealResult, true);
        } catch (\Exception $e) {
            return resp([], $e->getMessage(), Code::Failed);
        }

        return resp($data);
    }


    public function ossVerify(Request $request)
    {

        try {
            $dealResult = $this->ossService->ossVerify();



            // 注意一定要返回 json 格式的字符串，因为 oss 服务器只接收 json 格式，否则给前端报 CallbackFailed
           // return response()->json($dealResult);
            return resp($dealResult);
        } catch (\Exception $e) {
            return resp([], $e->getMessage(), Code::Failed);
        }
    }
}
