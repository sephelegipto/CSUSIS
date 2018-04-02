<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use DB;
use Auth;
class StudentController extends Controller
{
	public function Checklist(){
		$StudentID = Auth::user()->UserID;
		$x = DB::table('tusers')
		->join('tstudents', 'tstudents.StudentID', '=', 'tusers.UserID')->where('StudentID', '=', $StudentID)->pluck('CurriculumID');
		

		$checklists = DB::select("call spStudentChecklistsViewAllORSearch('Student Checklist','$x[0]','$StudentID')");
		$sem = collect(['First Semester', 'Second Semester', 'Summer']);
		$collection = collect(['First Year', 'Second Year', 'Third Year', 'Fourth Year', 'Fifth Year']);
		return view('student/checklist', compact('checklists','title','years','collection','sem','maj9or'));

	}
	public function adminstudentchecklist($StudentID){
	
		$x = DB::table('tusers')
		->join('tstudents', 'tstudents.StudentID', '=', 'tusers.UserID')->where('tstudents.StudentID', '=', $StudentID)->pluck('CurriculumID');


		$checklists = DB::select("call spStudentChecklistsViewAllORSearch('Student Checklist','$x[0]','$StudentID')");
		$sem = collect(['First Semester', 'Second Semester', 'Summer']);
		$collection = collect(['First Year', 'Second Year', 'Third Year', 'Fourth Year', 'Fifth Year']);
		return view('student/checklist', compact('checklists','title','years','collection','sem','maj9or'));

	}
}

