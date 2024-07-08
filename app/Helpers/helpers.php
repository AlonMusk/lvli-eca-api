<?php

/**
 * 响应格式
 */
if (!function_exists('resp')) {
    function resp( $data = [], $msg = 'success',$code = 200) {
        return response()->json([
            'code'  => $code,
            'msg'   => $msg,
            'data'  => $data,
        ]);
    }
}

if (!function_exists('genTradeNo')) {
    function genTradeNo( $length = 20) {

       return substr(uniqid(), 0, $length);
    }
}

if (!function_exists('genRedisPrefix')) {
    function genRedisPrefix() {

       return config('database.redis.default.prefix');
    }
}

//

    // /**
    //  * Get the auth instance.
    //  *
    //  * @return \Dingo\Api\Auth\Auth
    //  */
    // if (!function_exists('auth')) {
    //      function auth()
    //     {
    //         return app(Auth::class);
    //     }
    // }    
