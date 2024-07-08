<?php

namespace App\Exceptions;

use Exception;
use Illuminate\Foundation\Exceptions\Handler as ExceptionHandler;
use Illuminate\Support\Facades\Log;
use App\Exceptions\Code;
use App\Exceptions\Msg;
use Symfony\Component\HttpKernel\Exception\NotFoundHttpException;

class ApiExceptionHandler extends ExceptionHandler
{
  public function render($request, Exception $exception)
  {
  
    $msg = "";

    //   Log::error($exception);

    $msg = $exception->getMessage();
    if($msg == 'Unauthenticated.'){
    //  return resp([], $msg, Code::Unauthorized);
    }
    if($msg == 'Token has expired'){
      //  return resp([], $msg, Code::Unauthorized);
      return resp([], $msg, Code::Unauthorized);
      }
    return resp([$exception], $msg, Code::Failed);

    return parent::render($request, $exception);
  }
}
