<?php 

namespace App\Validators;

use Illuminate\Support\Facades\Validator;
use Illuminate\Validation\ValidationException;
use App\Exceptions\Code;

class ApiValidator
{
    public static function validate(array $data, array $rules, array $messages = [])
    {
        try{
            $validator = Validator::make($data, $rules, $messages);
            if ($validator->fails()) {
                throw new ValidationException($validator);
            }
        } catch (ValidationException $e) {
            $errors = $e->errors();
            $firstError = reset($errors)[0];
            return $firstError;
            return resp([],$firstError ,Code::Failed);
        }
        
       
        return '';
    }
}