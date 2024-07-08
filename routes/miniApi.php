<?php

use Illuminate\Http\Request;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/



Route::prefix('mini/v1')
    ->namespace('Base')
    ->group(function () {
        Route::post('/login', 'LoginController@login');
        Route::post('/register', 'RegisterController@create');


        Route::get('/addrList', 'AddrController@list');
        Route::get('/addrDetail', 'AddrController@detail');
        Route::post('/addrEdit', 'AddrController@edit');
        Route::post('/addrAdd', 'AddrController@add');
    });

Route::prefix('mini/v1')
    ->namespace('Base')
    ->middleware(['auth:miniApi'])
    ->group(function () {
        Route::post('/logout', 'LoginController@logout');

    });

Route::namespace('Product')
    ->prefix('mini/v1')
    ->middleware(['auth:miniApi'])
    ->group(function () {

        Route::post('/pay', 'MiniPayController@pay');
    });

Route::namespace('Product')
    ->prefix('mini/v1')
    //->middleware(['auth:miniApi'])
    ->group(function () {
        Route::get('/spuList', 'ProductController@list');
        Route::get('/spuDetail', 'ProductController@detail');
        Route::any('/payCallback', 'MiniPayController@payCallback');

        //分类列表
        Route::get('/catList', 'CatController@list');
    });


Route::namespace('Order')
    ->prefix('mini/v1')
    ->middleware(['auth:miniApi'])
    ->group(function () {
        Route::get('/orderList', 'OrderController@list');
        Route::get('/orderDetail', 'OrderController@detail');
        Route::post('/orderRefund', 'OrderController@Refund');
        Route::post('/orderDel', 'OrderController@Del');
    });


Route::namespace('Cart')
    ->prefix('mini/v1')
    ->middleware(['auth:miniApi'])
    ->group(function () {
        Route::get('/cartList', 'CartController@list');
        Route::get('/cartDetail', 'CartController@detail');

        Route::post('/cartAdd', 'CartController@add');
        Route::post('/cartEdit', 'CartController@edit');
    });
