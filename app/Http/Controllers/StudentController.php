<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use DB;
use Auth;
class StudentController extends Controller
{
	public function Checklist(){

		$x = DB::table('tusers')
		->join('tstudents', 'tstudents.StudentID', '=', 'tusers.UserID')->pluck('CurriculumID');

		$checklists = DB::select("call spLibraryViewAllORSearch('Checklists','$x[0]')");
		$sem = collect(['First Semester', 'Second Semester', 'Summer']);
		$collection = collect(['First Year', 'Second Year', 'Third Year', 'Fourth Year', 'Fifth Year']);
		return view('student/checklist', compact('checklists','title','years','collection','sem','maj9or'));

	}
}

