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
		return view('student/checklist/checklist', compact('checklists','title','years','collection','sem','major', 'StudentID'));

	}


	public function Enroll(){
		$StudentID = Auth::user()->UserID;
		$x = DB::table('tusers')
		->join('tstudents', 'tstudents.StudentID', '=', 'tusers.UserID')->where('StudentID', '=', $StudentID)->pluck('CurriculumID');
		

		$checklists = DB::select("call spStudentChecklistsViewAllORSearch('Student Checklist','$x[0]','$StudentID')");
		$sem = collect(['First Semester', 'Second Semester', 'Summer']);
		$collection = collect(['First Year', 'Second Year', 'Third Year', 'Fourth Year', 'Fifth Year']);
		return view('student/checklist/evaluate', compact('checklists','years','collection','sem','major', 'StudentID'));

	}

	public function AddUpdateGrade(Request $request){
		$StudentID = $request->StudentID;
		$SubjectID = $request->SubjectID;
		$Grade = $request->Grade;
		$count = DB::table('tstudentgrades')
		->where('StudentID', $StudentID)
		->where('SubjectID', $SubjectID)
		->count();
		if (empty($count)){

			DB::table('tstudentgrades')->insert(
				['StudentID' => $StudentID, 
				'SubjectID' => $SubjectID , 
				'Grade' => $Grade 
			]
		);
		} else {
			DB::table('tstudentgrades')
			->where('StudentID',  $StudentID)
			->where('SubjectID', $SubjectID)
			->update(['Grade' => $Grade]);
		}

	}
	
}

