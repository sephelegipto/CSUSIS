<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use DB;
class AdminCurriculumController extends Controller
{
    public function ViewCurriculumChecklist($id,$title,$years,$major){
		$checklists = DB::select("call spLibraryViewAllORSearch('Checklists','$id')");
		$sem = collect(['First Semester', 'Second Semester', 'Summer']);
		$collection = collect(['First Year', 'Second Year', 'Third Year', 'Fourth Year', 'Fifth Year']);
		return view('admin/checklist/checklist', compact('checklists','title','years','collection','sem','major'));

	}
}
