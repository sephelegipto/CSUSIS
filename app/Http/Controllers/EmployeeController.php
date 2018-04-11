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

		$childrens = DB::table('temployeeChildrens')->where('EmployeeID', $UserID)->get();

		$ELEMENTARY = DB::table('temployeeEB')->where('EmployeeID', $UserID)->where('EBLevelID', 1)->get();
		$SECONDARY = DB::table('temployeeEB')->where('EmployeeID', $UserID)->where('EBLevelID', 2)->get();
		$VOCATIONAL = DB::table('temployeeEB')->where('EmployeeID', $UserID)->where('EBLevelID', 3)->get();
		$COLLEGE = DB::table('temployeeEB')->where('EmployeeID', $UserID)->where('EBLevelID', 4)->get();
		$GRADUATE  = DB::table('temployeeEB')->where('EmployeeID', $UserID)->where('EBLevelID', 5)->get();

		return view('employee/employeepds',compact('empDetails', 'ELEMENTARY', 'SECONDARY', 'VOCATIONAL', 'COLLEGE', 'GRADUATE', 'childrens'));
	}
}
