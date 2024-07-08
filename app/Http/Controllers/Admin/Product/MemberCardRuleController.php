<?php

namespace App\Http\Controllers\Admin\Product;

use App\Http\Controllers\Controller;
use App\Exceptions\Code;
use App\Exceptions\Msg;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use App\Validators\ApiValidator;
use Illuminate\Auth\Events\Failed;

use App\Models\MemberCardRule; 
use App\Models\MemberCard;
class MemberCardRuleController extends Controller
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


        $query = MemberCardRule::orderBy('created_at', 'desc');

        if($request->name){
            $query = $query->where('name','like','%'.$request->name.'%');
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

        if(empty($dealResult)){
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
            'name' => 'required|unique:li_member_card',
            // 'title' => 'required|unique:posts|max:255',
            'card_id' => 'required',
            'type' => 'required',
            'num' => 'required',
            'unit' => 'required',
            'rate' => 'required',
        ]))) {
            return resp([], $validatedData, Code::Failed);
        }

        $model0 = MemberCard::find($request->card_id);
            if(!$model0){
                return resp([], '该会员卡数据不存在', Code::Failed);
            }
        $data = request()->all();
        // 表单验证
        $model = new MemberCardRule;

        $model->fill($data);
        $outFormat = $model->save();

        return resp($outFormat);
    }

    public function edit(Request $request)
    {
        if (!empty($validatedData = ApiValidator::validate($request->all(), [
            'id' => 'required',
            'name' => 'required|unique:li_member_card',
            // 'title' => 'required|unique:posts|max:255',
            'card_id' => 'required',
            'type' => 'required',
            'num' => 'required',
            'unit' => 'required',
            'rate' => 'required',

        ]))) {
            return resp([], $validatedData, Code::Failed);
        }

        try {
            $model0 = MemberCard::find($request->card_id);
            if(!$model0){
                return resp([], '该会员卡数据不存在', Code::Failed);
            }
            $model = MemberCardRule::find($request->id);
            if(!$model){
                return resp([], '该数据不存在', Code::Failed);
            }
            $data = $request->all();
            $model->fill($data);

            $dealResult =  $model->save();
        } catch (\Exception $e) {
            return resp([], $e->getMessage(), Code::Failed);
        }

        $outFormat = $dealResult;

        return resp($outFormat);
    }

    public function detail(Request $request)
    {
        $dealResult = MemberCardRule::find($request->id);
        $outFormat = $dealResult;
        return resp($outFormat);
    }
}
