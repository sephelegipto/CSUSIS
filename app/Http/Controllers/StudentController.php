<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use DB;
use Auth;
class StudentController extends Controller
{
	public function Checklist(){
		$x = Auth::user()->curriculum_id;
		$checklists = DB::select("call spLibraryViewAllORSearch('Checklists','$x')");
		$sem = collect(['First Semester', 'Second Semester', 'Summer']);
		$collection = collect(['First Year', 'Second Year', 'Third Year', 'Fourth Year', 'Fifth Year']);
		return view('student/checklist', compact('checklists','title','years','collection','sem','major'));

	}
}
