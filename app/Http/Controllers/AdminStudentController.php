<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use DB;
class AdminStudentController extends Controller
{
	public function ViewStudentChecklist($StudentID){

		$x = DB::table('tusers')
		->join('tstudents', 'tstudents.StudentID', '=', 'tusers.UserID')->where('tstudents.StudentID', '=', $StudentID)->pluck('CurriculumID');

		$StudentID = $StudentID;
		$checklists = DB::select("call spStudentChecklistsViewAllORSearch('Student Checklist','$x[0]','$StudentID')");
		$sem = collect(['First Semester', 'Second Semester', 'Summer']);
		$collection = collect(['First Year', 'Second Year', 'Third Year', 'Fourth Year', 'Fifth Year']);
		return view('admin/student/checklist', compact('checklists','title','years','collection','sem','maj9or', 'StudentID'));

	}



	public function 	EvaluateStudent($StudentID){

		$x = DB::table('tusers')
		->join('tstudents', 'tstudents.StudentID', '=', 'tusers.UserID')->where('tstudents.StudentID', '=', $StudentID)->pluck('CurriculumID');

		$StudentID = $StudentID;
		$checklists = DB::select("call spStudentChecklistsViewAllORSearch('Student Checklist','$x[0]','$StudentID')");
		dump($checklists);
		$sem = collect(['First Semester', 'Second Semester', 'Summer']);
		$collection = collect(['First Year', 'Second Year', 'Third Year', 'Fourth Year', 'Fifth Year']);
		return view('admin/student/evaluate', compact('checklists','title','years','collection','sem','maj9or', 'StudentID'));

	}
}
