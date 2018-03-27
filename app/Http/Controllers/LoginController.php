<?php

namespace App\Http\Controllers;
use App\Http\Controllers\Controller;
use Illuminate\Foundation\Auth\AuthenticatesUsers;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use App\tuser;




class LoginController extends Controller 
{

    use AuthenticatesUsers;
    protected $username = 'username';
    protected $redirectTo = '/admin';
    protected $guard = 'web';



    public function getLogin()
    {
        if (Auth::guard('web')->check())
            {
                return redirect()->route('dashboard');
            }

            return view('login');
        }

        public function index()
        {
            $user_id = Auth::user()->id;
            return $user_id;
        }
        public function postLogin(Request $request)
        {
           $user = tuser::where('LoginID', $request->username)
           ->where('password', $request->password)
           ->first();
           if(empty($user)){
              return redirect()->route('/');
          }
          $auth =  Auth::login($user);
          if ($auth)
          {
            return redirect()->route('curriculumlist');
        } 
        return redirect()->route('/');
    }

    public function getLogout()
    {
        Auth::guard('web')->logout();
        return redirect()->route('/');
    }

    public function zxc()
    {
        return view('layouts.welcome');
    }
}
