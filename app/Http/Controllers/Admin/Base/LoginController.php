<?php

namespace App\Http\Controllers\Admin\Base;

use App\Http\Controllers\Controller;
use Illuminate\Foundation\Auth\AuthenticatesUsers;
use App\Exceptions\Code;
use App\Exceptions\Msg;
use Carbon\Carbon as CarbonCarbon;
use Illuminate\Http\Request;
use Illuminate\Support\Carbon;

class LoginController extends Controller
{
    /*
    |--------------------------------------------------------------------------
    | Login Controller
    |--------------------------------------------------------------------------
    |
    | This controller handles authenticating users for the application and
    | redirecting them to your home screen. The controller uses a trait
    | to conveniently provide its functionality to your applications.
    |
    */

   

    /**
     * Where to redirect users after login.
     *
     * @var string
     */
    protected $redirectTo = '/home';


    /**
     * Create a new controller instance.
     *
     * @return void
     */
    public function __construct()
    {
    }


    public function username()
    {
        return 'username';
    }

    public function login(Request $request)
    {

        $credentials = $request->only(["username", "password"]);

        if (!$token = auth('adminApi')->attempt($credentials)) {
            return resp([], "账号或者密码有误", 500);
        }
        $expire = env('JWT_TTL',600);
        $now = Carbon::now()->timestamp;
        return resp(['expire'=> $expire,'now'=>$now,'access_token' => $token]);
        return 'admin api';
    }
     /**
     * Refresh a token.
     * 刷新token
     * @return \Illuminate\Http\JsonResponse
     */
    public function refresh()
    {
        $token = auth('adminApi')->refresh();
        $expire = env('JWT_TTL',600);
        $now = Carbon::now()->timestamp;
        return resp(['expire'=> $expire,'now'=>$now,'access_token' => $token]);
    }



    public function logout()
    {
        $token = auth('adminApi')->logout();
        return resp([]);
    }

}
