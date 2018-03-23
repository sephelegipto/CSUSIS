<?php

namespace App\Http\Controllers;

use Illuminate\Foundation\Bus\DispatchesJobs;
use Illuminate\Routing\Controller as BaseController;
use Illuminate\Foundation\Validation\ValidatesRequests;
use Illuminate\Foundation\Auth\Access\AuthorizesRequests;
use DB;
class Controller extends BaseController
{
	use AuthorizesRequests, DispatchesJobs, ValidatesRequests;


	public function dashboard(){
		

		return view('dashboard/dashboard');
	}

	public function employee(){
		$employees = DB::select("call spLibraryViewAllORSearch('Employees','')");

		return view('employee/employee', compact('employees'));
	}

	public function department(){
		$departments = DB::select("call spLibraryViewAllORSearch('Departments','')");

		return view('department/department', compact('departments'));
	}

	public function building(){
		$buildings = DB::select("call spLibraryViewAllORSearch('Buildings','')");

		return view('building/building', compact('buildings'));
	}
}
