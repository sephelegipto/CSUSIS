<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use DB;
class CurriculumController extends Controller
{
	public function index(){
		$curriculums = DB::select("call spLibraryViewAllORSearch('Curriculums','')");
		return view('curriculum/CurriculumList', compact('curriculums'));

	}

	public function viewchecklist($id,$title,$years,$major){
		$checklists = DB::select("call spLibraryViewAllORSearch('Checklists','$id')");
		$sem = collect(['First Semester', 'Second Semester', 'Summer']);
		$collection = collect(['First Year', 'Second Year', 'Third Year', 'Fourth Year', 'Fifth Year']);
		return view('checklist/checklist', compact('checklists','title','years','collection','sem','major'));

	}
}
