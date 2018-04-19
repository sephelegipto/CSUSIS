<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Foundation\Auth\AuthenticatesUsers;
use DB;
use Illuminate\Support\Facades\Auth;
use App\EmployeePI;
use App\Employees;
use App\EmployeeFB;
use App\EmployeeReferences;
use App\EmployeeChildren;
class EmployeeController extends Controller
{
	public function ViewPds(){
		$UserID = Auth::user()->UserID;

		$UserID = DB::table('temployees')->where('EmployeeID', '=', $UserID)->pluck('ID');

		$empDetails = DB::table('temployees')

		->leftjoin('temployeespersonalinformation', 'temployees.ID', '=', 'temployeespersonalinformation.EmployeeID')
		->leftjoin('temployeesfamilybackground', 'temployees.ID', '=', 'temployeesfamilybackground.EmployeeID')
		->select('temployees.*', 'temployees.*', 'temployeespersonalinformation.*', 'temployeesfamilybackground.*')
		->where('temployees.ID', $UserID[0])
		->get();



		$childrens = DB::table('temployeeChildrens')->where('EmployeeID', $UserID)->get();
		$references = DB::table('temployeesreferences')->where('EmployeeID', $UserID)->get();

		$ELEMENTARY = DB::table('temployeeseducationbackground')->where('EmployeeID', $UserID)->where('EBLevelID', 1)->get();
		$SECONDARY = DB::table('temployeeseducationbackground')->where('EmployeeID', $UserID)->where('EBLevelID', 2)->get();
		$VOCATIONAL = DB::table('temployeeseducationbackground')->where('EmployeeID', $UserID)->where('EBLevelID', 3)->get();
		$COLLEGE = DB::table('temployeeseducationbackground')->where('EmployeeID', $UserID)->where('EBLevelID', 4)->get();
		$GRADUATE  = DB::table('temployeeseducationbackground')->where('EmployeeID', $UserID)->where('EBLevelID', 5)->get();

		return view('employee/employeepds',compact('empDetails', 'ELEMENTARY', 'SECONDARY', 'VOCATIONAL', 'COLLEGE', 'GRADUATE', 'childrens', 'references', 'UserID'));
	}

	public function UpdatePersonalInformation(Request $request){
		if ($request->ajax())
		{
			EmployeePI::updateOrCreate(['EmployeeID'=>$request->EmployeeID],$request->all());
			Employees::updateOrCreate(['ID'=>$request->EmployeeID],$request->all());
		}
	}

	
	public function UpdateFamilyBackground(Request $request){
		if ($request->ajax())
		{

			return response(EmployeeFB::updateOrCreate(['EmployeeID'=>$request->EmployeeID],$request->all()));
		}
	}

	public function AddChildren(Request $request){
		if ($request->ajax())
		{


			return response(EmployeeChildren::updateOrCreate(['EmployeeID'=>$request->EmployeeID, 'Name'=>$request->Name],$request->all()));
		}
	}

	public function EditChildren(Request $request){
		if ($request->ajax())
		{
			return response(EmployeeChildren::updateOrCreate(['ID'=>$request->ID], $request->all()));
		}
	}

	public function DeleteChildren(Request $request){
		if ($request->ajax())
		{
			$info = EmployeeChildren::find($request->ID);
			EmployeeChildren::destroy($request->ID);
			return response($info);
		}
	}

	public function UpdateReferences(Request $request){
		if ($request->ajax())
		{

			for($i = 0;$i <= 2;$i++)
			{
				EmployeeReferences::updateOrCreate(['ID'=>$request->ID[$i]],['EmployeeID'=> $request->EmployeeID, 'Name'=> $request->Name[$i], 'Address'=> $request->Address[$i], 'ContactNumber' => $request->ContactNumber[$i]]);
			}
			
		}
	}
	
}
