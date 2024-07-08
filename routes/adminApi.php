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


Route::namespace('Base')
    ->prefix('admin/v1')
    ->group(function () {
        Route::post('/login', 'LoginController@login');
        Route::post('/register', 'RegisterController@create');
        Route::post('/refresh', 'LoginController@refresh');
        Route::post('/logout', 'LoginController@logout');

        Route::any('/ossVerify', 'OssController@ossVerify');
    });


Route::namespace('Base')
    ->prefix('admin/v1')
    ->middleware(['auth:adminApi'])
    ->group(function () {



        Route::get('/ossPolicy', 'OssController@ossPolicy');


        // 分销
        Route::post('/disAdd', 'DisController@add');
        Route::post('/disEdit', 'DisController@edit');
        Route::get('/disList', 'DisController@list');

        // 分销规则
        Route::post('/disRuleAdd', 'DisRuleController@add');
        Route::post('/disRuleEdit', 'DisRuleController@edit');
        Route::get('/disRuleList', 'DisRuleController@list');
    });

//账号管理
Route::namespace('Account')
    ->prefix('admin/v1/account')
    ->middleware(['auth:adminApi'])
    ->group(function () {
        Route::get('/userList', 'UserListController@list');
        Route::post('/userAdd', 'UserListController@add');
        Route::get('/userDetail', 'UserListController@detail');
        Route::post('/userEdit', 'UserListController@edit');
    });

//产品管理
Route::namespace('Product')
    ->prefix('admin/v1/product')
    ->middleware(['auth:adminApi'])
    ->group(function () {
        //产品
        Route::post('/spuAdd', 'ProductController@add');
        Route::post('/spuEdit', 'ProductController@edit');
        Route::get('/spuList', 'ProductController@list');
        Route::get('/spuDetail', 'ProductController@detail');

        //sku
        Route::post('/skuAdd', 'SkuController@add');
        Route::post('/skuEdit', 'SkuController@edit');
        Route::get('/skuList', 'SkuController@list');

        // 品牌
        Route::post('/brandAdd', 'BrandController@add');
        Route::post('/brandEdit', 'BrandController@edit');
        Route::post('/brandDel', 'BrandController@del');
        Route::get('/brandList', 'BrandController@list');

        // 分类
        Route::post('/catAdd', 'CatController@add');
        Route::post('/catEdit', 'CatController@edit');
        Route::get('/catList', 'CatController@list');
        Route::post('/catDel', 'CatController@del');
        Route::get('/catDetail', 'CatController@detail');

        // 属性--这个是想做规格？
        Route::post('/attrAdd', 'AttrController@add');
        Route::post('/attrEdit', 'AttrController@edit');
        Route::get('/attrList', 'AttrController@list');

        // 参数
        Route::post('/paramAdd', 'ParamController@add');
        Route::post('/paramEdit', 'ParamController@edit');
        Route::get('/paramList', 'ParamController@list');
        Route::post('/paramDel', 'ParamController@del');
        Route::get('/paramDetail', 'ParamController@detail');

        // 标签
        Route::post('/tagAdd', 'TagController@add');
        Route::post('/tagEdit', 'TagController@edit');
        Route::get('/tagList', 'TagController@list');
        Route::post('/tagDel', 'TagController@del');
        Route::get('/tagDetail', 'TagController@detail');

        // 数量单位
        Route::post('/numUnitAdd', 'NumUnitController@add');
        Route::post('/numUnitEdit', 'NumUnitController@edit');
        Route::post('/numUnitDel', 'NumUnitController@del');
        Route::get('/numUnitList', 'NumUnitController@list');
        Route::get('/numUnitDetail', 'NumUnitController@detail');


        //  容量单位
        Route::post('/volumeUnitAdd', 'VolumeUnitController@add');
        Route::post('/volumeUnitEdit', 'VolumeUnitController@edit');
        Route::get('/volumeUnitList', 'VolumeUnitController@list');


        // 会员卡
        Route::post('/memberCardAdd', 'MemberCardController@add');
        Route::post('/memberCardEdit', 'MemberCardController@edit');
        Route::get('/memberCardList', 'MemberCardController@list');

        // 会员卡规则
        Route::post('/memberCardRuleAdd', 'MemberCardRuleController@add');
        Route::post('/memberCardRuleEdit', 'MemberCardRuleController@edit');
        Route::get('/memberCardRuleList', 'MemberCardRuleController@list');

        // 会员商品
        Route::post('/memberSkuAdd', 'MemberSkuController@add');
        Route::post('/memberSkuEdit', 'MemberSkuController@edit');
        Route::get('/memberSkuList', 'MemberSkuController@list');


        // 活动
        Route::post('/actAdd', 'ActController@add');
        Route::post('/actEdit', 'ActController@edit');
        Route::get('/actList', 'ActController@list');

        // 活动规则
        Route::post('/actRuleAdd', 'ActRuleController@add');
        Route::post('/actRuleEdit', 'ActRuleController@edit');
        Route::get('/actRuleList', 'ActRuleController@list');

        // 活动商品
        Route::post('/actSpuAdd', 'ActSpuController@add');
        Route::post('/actSpuEdit', 'ActSpuController@edit');
        Route::get('/actSpuList', 'ActSpuController@list');

        // 活动用户
        Route::post('/actUserAdd', 'ActUserController@add');
        Route::post('/actUserEdit', 'ActUserController@edit');
        Route::get('/actUserList', 'ActUserController@list');
    });

//客户管理
Route::namespace('Customer')
    ->prefix('admin/v1/customer')
    ->middleware(['auth:adminApi'])
    ->group(function () {
        Route::get('/userList', 'UserListController@list');
        Route::post('/userAdd', 'UserListController@add');
        Route::get('/userDetail', 'UserListController@detail');
        Route::post('/userEdit', 'UserListController@edit');
    });

//订单管理
Route::namespace('Order')
    ->prefix('admin/v1/order')
    ->middleware(['auth:adminApi'])
    ->group(function () {
        Route::get('/orderList', 'OrderController@list');
        Route::get('/orderDetail', 'OrderController@detail');
        Route::post('/orderEdit', 'OrderController@edit');
        //打印小票
        //删除
        //发货:填写快递信息
        //退款
        Route::post('/orderRefund', 'PcPayController@refund');
    });

Route::namespace('Order')
    ->prefix('mini/v1/order')
    ->group(function () {
        Route::any('/refundCallback', 'PcPayController@refundCallback');
    });

Route::namespace('Stock')
    ->prefix('admin/v1')
    ->middleware(['auth:adminApi'])
    ->group(function () {
        // Route::get('/UserList', 'UserListController@list');

    });
