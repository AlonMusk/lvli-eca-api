<?php

namespace App\Http\Controllers\Mini\Product;

use App\Http\Controllers\Controller;
use App\Exceptions\Code;
use App\Exceptions\Msg;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use App\Models\Product;

class ProductController extends Controller
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


        $query = Product
        ::with(['sku'=>function ($query) {
            //$query->where('content', 'like', 'foo%');
            $query->select(['id','spu_id','price','old_price']);//->where('spu_id', $request->id);
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

        //顶部导航栏
        $topBar = [
            ['id'=>1,'name'=>'推荐'],
        ];
        //轮播图
        $swiperList = [
            ['id'=>1,'imgUrl'=>'http://static.lvlics.com/liquor/78RkQ2djys.jpg','url'=>'/pages/details/details?id=1'],
            ['id'=>2,'imgUrl'=>'http://static.lvlics.com/liquor/XQQYxFWFyG.png','url'=>'/pages/details/details?id=2'],
        ];
        //商品列表
        $commodityList = [
            ['id'=>1,'discount'=>'5.2','imgUrl'=>'http://static.lvlics.com/liquor/Prb846jTxH.jpg','name'=>'1好啤酒--这里的标题非常长这里的标题非常长这里的标题非常长这里的标题非常长','oprice'=>659,'pprice'=>299],
            ['id'=>2,'discount'=>'5.2','imgUrl'=>'http://static.lvlics.com/liquor/Prb846jTxH.jpg','name'=>'1好啤酒--这里的标题非常长这里的标题非常长这里的标题非常长这里的标题非常长','oprice'=>659,'pprice'=>299],
         ['id'=>3,'discount'=>'5.2','imgUrl'=>'http://static.lvlics.com/liquor/Prb846jTxH.jpg','name'=>'1好啤酒--这里的标题非常长这里的标题非常长这里的标题非常长这里的标题非常长','oprice'=>659,'pprice'=>299],
         ['id'=>4,'discount'=>'5.2','imgUrl'=>'http://static.lvlics.com/liquor/Prb846jTxH.jpg','name'=>'1好啤酒--这里的标题非常长这里的标题非常长这里的标题非常长这里的标题非常长','oprice'=>659,'pprice'=>299],

        ];


      //  dd($dealResult);
        //$dealResult = [];
        $prefix = env('OSS_ACCESS_URL','http://static.lvlics.com');
        //轮播图
        $swiperList= array_map(function ($item) use ($prefix) {
            $subImgs=explode(',',$item['sub_img']);
            return [
                'id' =>$item['id'],
                'imgUrl'=>$prefix . $subImgs[0],
                'url'=>'/pages/details/details?id='.$item['id'],
             ];
        }, $dealResult );

         //商品列表
         $commodityList= array_map(function ($item) use ($prefix) {
            return [
                'id' =>$item['id'],
                'discount'=>   intval(($item['sku'][0]['price']  / $item['sku'][0]['old_price'])*100)/10,
                'imgUrl'=>$prefix . $item['main_img'],
                'name'=>$item['name'],
                'title'=>$item['title'],
                'oprice'=>$item['sku'][0]['old_price'],
                'pprice'=>$item['sku'][0]['price']
             ];
        }, $dealResult );



        $data = [
            ['type'=>'swiperList','data'=>$swiperList],
             ['type'=>'commodityList','data'=>$commodityList],
        ];

        $outFormat = [
            'topBar' =>$topBar,
            'data' => $data,
            'total' => $total,
            'page_size' => $limit,
            'current_page' => $current_page
        ];

        return resp($outFormat);
    }

    public function detail(Request $request)
    {
        $detail = Product::find($request->id);
        if (!$detail) {
            return resp([], '数据不存在', Code::Failed);
        }

         $subImgs = [];
         $prefix = env('OSS_ACCESS_URL','http://static.lvlics.com');
        if(!empty($detail->sub_img)){
            $subImgs = explode(',', $detail->sub_img);
            // $subImgs= collect($subImgs)->map(function($item)use($prefix){
            //     $item =  $prefix.$item;
            // })->all();
            $subImgs = array_map(function ($item) use ($prefix) {
                return ['imgUrl'=>$prefix . $item];
            }, $subImgs);

        }
        $detail->main_img =$prefix.$detail->main_img;
             $detail->sub_img = $subImgs;

             $sku = $detail->sku()->select(['id','spu_id','price','old_price'])->where('spu_id', $request->id)->get()->toArray();
             $detail = $detail->toArray();
           //  $detail['sku'] = $detail->sku->toArray();
             //dd($detail);
             if(empty( $sku)){
                 $sku = [
                     [
                         'id'=>0,
                         "spu_id"=>$request->id,
                         'price' =>'',
                         "old_price"=>"",
                         "discount"=>""
                     ]
                 ];
             }else{
                 $sku = array_map(function ($item)  {
                     $item['discount'] =  intval(($item['price']  / $item['old_price'])*100)/10;
                     return  $item;
                 }, $sku);
             }
             $detail['sku'] =$sku;

        $outFormat = [];
        return resp($detail);
    }

}
