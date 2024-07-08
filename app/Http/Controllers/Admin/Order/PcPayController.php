<?php

namespace App\Http\Controllers\Admin\Order;

use App\Http\Controllers\Controller;
use App\Exceptions\Code;
use App\Exceptions\Msg;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;

use  App\Service\Admin\PcPayService as  PayRepository;
use Illuminate\Support\Facades\Response;
use App\Models\Order;

class PcPayController extends Controller
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
   * 微信支付--退款
   *
   * @return Response
   */

  public function refund(Request $request)
  {
      if (!empty($validatedData = ApiValidator::validate($request->all(), [
          'order_no' => 'required',
          'refund_amount' => 'required',
      ]))) {
          return resp([], $validatedData, Code::Failed);
      }
      $data = $request->all();
      try {
          $dealResult = $this->pay_repository->refund($data);
      } catch (\Exception $e) {
          return resp([], $e->getMessage(), Code::Failed);
      }

      $outFormat = $dealResult;

      return resp($outFormat);
  }

  //退款回调
  public function refundCallback(Request $request)
  {
    return  $this->pay_repository->refundCallback();
  }
}
