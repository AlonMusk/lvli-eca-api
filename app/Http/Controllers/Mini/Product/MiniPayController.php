<?php

namespace App\Http\Controllers\Mini\Product;

use App\Http\Controllers\Controller;
use App\Exceptions\Code;
use App\Exceptions\Msg;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;

use  App\Service\Mini\MiniPayService as  PayRepository;
use Illuminate\Support\Facades\Response;
use App\Models\Order;

class MiniPayController extends Controller
{


  /**
   * PayRepository
   *
   * @var PayRepository
   */
  protected $pay_repository;

  public function __construct(PayRepository $pay_repository)
  {
    $this->pay_repository = $pay_repository;
  }

  /**
   * 微信支付
   *
   * @return Response
   */
  public function pay(Request $request)
  {
    //  $user = auth()->user();
    //$orderInfo = $request->all();
    $user = Auth::user();
    try {
      $pay = $this->pay_repository->pay($user, $request);
    } catch (\Exception $e) {
      return resp([], $e->getMessage(), Code::Failed);
    }

    //  return resp(['pay' => $user]);

    return resp(['pay' => $pay]);
  }



  public function payCallback(Request $request)
  {
    //  $message = $request->all();
    //   Log::info( $message);return true;
    return  $this->pay_repository->payCallback();
  }

  
}
