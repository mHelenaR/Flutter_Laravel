<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
//use Illuminate\Support\Facades\Validator;
use Illuminate\Http\Request;
use Validator;
use Auth;
use App\Models\User;

class AuthController extends Controller
{
    public function login(Request $request)
        {
            $validation = Validator::make($request->all(), [
                'email'    => 'required|max:50|email',
                'password' => 'required',
            ]);
    
            if ($validation->fails()) {
                return \response()->json([
                    'message' => 'Erro ao validar dados',
                    'success' => false
                ]);
            }
    
            if (!Auth::attempt($request->only('email','password'))) {
                return \response()->json([
                    'message' => 'Usuário ou senha incorretos.',
                    'success' => false,
                ]);
    
            } else {
                $user = User::where('email', $request->email)->first();
                if ($user) {
                    return \response()->json([
                        'message' => 'Sucesso!',
                        'success' => true,
                        'token'   => $user->createToken(md5($user->email) . $user->email)->plainTextToken,
                    ]);
                }
            }
            return \response()->json([
                'message' => 'Erro inesperado',
                'success' => false,
            ]);
        }
}
