<?php

namespace App\Http\Controllers\Mini\Base;

use App\Http\Controllers\Controller;
use Illuminate\Foundation\Auth\AuthenticatesUsers;
use App\Exceptions\Code;
use App\Exceptions\Msg;
use Illuminate\Http\Request;
use App\Models\MiniUser as User;
use Illuminate\Support\Carbon;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;

use EasyWeChat\OfficialAccount\Application;

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
        // $this->middleware('jwt')->except('login,logout');
    }


    public function username()
    {
        return 'username';
    }

    public function getConfig(){
        return  [
            'app_id' =>  env('WECHAT_MINI_PROGRAM_APPID', ''),
            'secret' =>  env('WECHAT_MINI_PROGRAM_SECRET', ''),
        ];
    }


    public function login(Request $request)
    {
        $defaultAvator = "https://thirdwx.qlogo.cn/mmopen/vi_32/POgEwh4mIHO4nibH0KlMECNjjGxQUq24ZEaGT4poC6icRiccVGKSyXwibcPq4BWmiaIGuG1icwxaQX6grC9VemZoJ8rg/132";
        //手机号登录
        if ($request->type == 1) {
            $credentials = $request->only(["username", "password"]);
            $credentials['phone'] = $credentials['username'];
            unset($credentials['username']);
            if (!$token = auth('miniApi')->attempt($credentials)) {
                return resp([], "账号或者密码有误", 500);
            }
            $expire = env('JWT_TTL', 600);
            $now = Carbon::now()->timestamp;
            return resp([
                'username' => $request->username,
                'expire' => $expire,
                'now' => $now,
                'access_token' => $token,
                'avator' => $defaultAvator,
            ]);
        }
        //授权登录
       // $app =  app('wechat.mini_program');
       $config = $this->getConfig();
        $app = new Application($this->getConfig());

        https://api.weixin.qq.com/sns/jscode2session?appid=<AppId>&secret=<AppSecret>&js_code=<code>&grant_type=authorization_code

        $response = $app->getClient()->get("/sns/jscode2session?appid={$config['app_id']}&secret={$config['secret']}&js_code={$request->code}&grant_type=authorization_code");

        $data = $response->toArray();

        // $response = $app->getClient()->postJson('/sns/jscode2session', [
        //     'appid' => $config['app_id'],
        //     'secret' => $config['secret'],
        //     'js_code' => $request->code,
        //     'grant_type' => 'authorization_code',
        // ]);

// # 查看返回结果
// var_dump($response->toArray());


        //$data = $app->auth->session($request->code);

        if (isset($data['errcode'])) {
            return   resp(['code' => $request->code, 'data' => $data], 'code已过期或不正确', Code::Failed);
        }

        // $data["openid"] = "23444444444444444444";

        // $userInfo = $app->encryptor->decryptData($data['session_key'], $request->iv, $request->encryptedData);
        $password = '12345678';
        $username = '微信用户';
        $user =  User::where('openid', $data["openid"]);

        if ($user->doesntExist()) {

            $userInfo['openid'] = $data["openid"];

            // $userInfo['avatar'] = $userInfo['avatarUrl'];

            //  $userInfo['nickname'] = $userInfo['nickName'];

            //   $userInfo['name'] = $userInfo['nickName'];


            $userInfo['username'] = $username;
            $userInfo['password'] =  Hash::make($password);
            $userInfo['trade_no']  = genTradeNo();
            $res =  User::create($userInfo);
            $credentials = [
                'openid' => $data["openid"],
                'password' => $password
            ];
            if (!$token = auth('miniApi')->attempt($credentials)) {
                return resp([], "Unauthorized", 401);
            }
        } else {
            $user = User::where('openid', $data["openid"])->first();
            if (!$token = auth('miniApi')->login($user)) {
                return resp([], "Unauthorized", 401);
            }
        }
        
        $expire = env('JWT_TTL', 600);
        $now = Carbon::now()->timestamp;
        return resp([
            'username' => $username,
            'expire' => $expire,
            'now' => $now,
            'access_token' => $token,
            'avator' => $defaultAvator,
        ]);
    }

    public function logout()
    {
        $token = auth('miniApi')->logout();
        $res = $token;
        return resp([]);
    }
}
