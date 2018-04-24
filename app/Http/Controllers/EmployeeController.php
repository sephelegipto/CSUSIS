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
use App\EmployeeCSEligibilities;
use App\EmployeeWorkExperience;
use App\EmployeeVoluntarywork;
use App\EmployeeLearningDevelopments;
use App\EmployeeOtherinformations;



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
		$workexperiences = EmployeeWorkExperience::where('EmployeeID', '=' ,$UserID)->get();
		$CSEligibilities = EmployeeCSEligibilities::where('EmployeeID', '=' ,$UserID)->get();
		$voluntarywork =  EmployeeVoluntarywork::where('EmployeeID', '=' ,$UserID)->get();
		$learningdev =EmployeeLearningDevelopments::where('EmployeeID', '=' ,$UserID)->get();
		$otherinfo = EmployeeOtherinformations::where('EmployeeID', '=' ,$UserID)->get();

		return view('employee/employeepds',compact('empDetails', 'ELEMENTARY', 'SECONDARY', 'VOCATIONAL', 'COLLEGE', 'GRADUATE', 'childrens', 'references', 'UserID', 'CSEligibilities', 'workexperiences', 'voluntarywork', 'learningdev', 'otherinfo'));
	}

	public function UpdatePersonalInformation(Request $request){
		if ($request->ajax())
		{
			$UserID = Auth::user()->UserID;

			$UserID = DB::table('temployees')->where('EmployeeID', '=', $UserID)->pluck('ID');


			EmployeePI::updateOrCreate(['EmployeeID'=>$UserID],$request->all());
			Employees::updateOrCreate(['ID'=>$UserID],$request->all());
		}
	}

	
	public function UpdateFamilyBackground(Request $request){
		if ($request->ajax())
		{
			$UserID = Auth::user()->UserID;
			$UserID = DB::table('temployees')->where('EmployeeID', '=', $UserID)->pluck('ID');			
			return response(EmployeeFB::updateOrCreate(['EmployeeID'=>$UserID],$request->all()));
		}
	}

	public function AddChildren(Request $request){
		if ($request->ajax())
		{
			$UserID = Auth::user()->UserID;
			$EmployeeID = DB::table('temployees')->where('EmployeeID', '=', $UserID)->pluck('ID');	
			return response(EmployeeChildren::updateOrCreate(['EmployeeID'=>$UserID, 'EmployeeID' => $UserID],	
				[
					'EmployeeID' => $EmployeeID[0],
					'Name' => $request->Name,
					'Birthday' => $request->Birthday

				]));
		}
	}

	public function AddCSEligibility(Request $request){
		if ($request->ajax())
		{			
			return response(EmployeeCSEligibilities::updateOrCreate(['EmployeeID'=>$request->CareerService, 'CareerService'=>$request->CareerService],$request->all())->toArray());
		}
	}

	public function AddWorkExperience(Request $request){
		if ($request->ajax())
		{
			return response(EmployeeWorkExperience::updateOrCreate(['EmployeeID'=>$request->CareerService, 'InclusiveDateFrom'=>$request->InclusiveDateFrom],$request->all()));
		}
	}

	public function AddOtherInformation(Request $request){
		if ($request->ajax())
		{
			return response(EmployeeOtherinformations::updateOrCreate(['EmployeeID'=>$request->CareerService],$request->all()));
		}
	}

	public function EditOtherInformation(Request $request){
		if ($request->ajax())
		{
			return response(EmployeeOtherinformations::updateOrCreate(['ID'=>$request->ID], $request->all()));
		}
	}

	public function DeleteOtherInformation(Request $request){
		if ($request->ajax())
		{
			$info = EmployeeOtherinformations::find($request->ID);
			EmployeeOtherinformations::destroy($request->ID);
			return response($info);
		}
	}
	public function AddVoluntarilyWork(Request $request){
		if ($request->ajax())
		{
			return response(EmployeeVoluntarywork::updateOrCreate(['EmployeeID'=>$request->CareerService, 'InclusiveDateFrom'=>$request->InclusiveDateFrom],$request->all()));
		}
	}
	public function AddLearningDevelopment(Request $request){
		if ($request->ajax())
		{
			return response(EmployeeLearningDevelopments::updateOrCreate(['EmployeeID'=>$request->CareerService, 'InclusiveDateFrom'=>$request->InclusiveDateFrom],$request->all()));
		}
	}
	public function EditChildren(Request $request){
		if ($request->ajax())
		{
			return response(EmployeeChildren::updateOrCreate(['ID'=>$request->ID], $request->all()));
		}
	}

	public function EditCSEligibility(Request $request){
		if ($request->ajax())
		{
			return response(EmployeeCSEligibilities::updateOrCreate(['ID'=>$request->ID], $request->all()));
		}
	}

	public function EditVoluntarilyWork(Request $request){
		if ($request->ajax())
		{
			return response(EmployeeVoluntarywork::updateOrCreate(['ID'=>$request->ID], $request->all()));
		}
	}

	public function EditWorkexperience(Request $request){
		if ($request->ajax())
		{
			return response(EmployeeWorkExperience::updateOrCreate(['ID'=>$request->ID], $request->all()));
		}
	}

	public function EditLearningDevelopment(Request $request){
		if ($request->ajax())
		{
			return response(EmployeeLearningDevelopments::updateOrCreate(['ID'=>$request->ID], $request->all()));
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

	public function DeleteLearningAndDevelopment(Request $request){
		if ($request->ajax())
		{
			$info = EmployeeLearningDevelopments::find($request->ID);
			EmployeeLearningDevelopments::destroy($request->ID);
			return response($info);
		}
	}

	public function DeleteCSEligibility(Request $request){
		if ($request->ajax())
		{
			$info = EmployeeCSEligibilities::find($request->ID);
			EmployeeCSEligibilities::destroy($request->ID);
			return response($info);
		}
	}

	public function DeleteWorkExperience(Request $request){
		if ($request->ajax())
		{
			$info = EmployeeWorkExperience::find($request->ID);
			EmployeeWorkExperience::destroy($request->ID);
			return response($info);
		}
	}

	public function DeleteVoluntaryWork(Request $request){
		if ($request->ajax())
		{
			$info = EmployeeVoluntarywork::find($request->ID);
			EmployeeVoluntarywork::destroy($request->ID);
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
