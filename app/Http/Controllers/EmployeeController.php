<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Foundation\Auth\AuthenticatesUsers;
use DB;
use Illuminate\Support\Facades\Auth;
class EmployeeController extends Controller
{
	public function ViewPds(){
		$UserID = Auth::user()->UserID;

		$empDetails = DB::table('tusers')
		->join('temployees', 'tusers.UserID', '=', 'temployees.EmployeeID')
		->join('temployeePI', 'tusers.UserID', '=', 'temployeePI.EmployeeID')
		->join('temployeeFB', 'tusers.UserID', '=', 'temployeeFB.EmployeeID')
		->select('tusers.*', 'temployees.*', 'temployeePI.*', 'temployeeFB.*')
		->where('tusers.UserID', $UserID)
		->get();

		return view('employee/employeepds',compact('empDetails'));
	}
}
