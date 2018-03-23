<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use DB;
class CourseController extends Controller
{
    public function index(){
		$courses = DB::select("call spLibraryViewAllORSearch('courses','')");

		return view('courses/courses', compact('courses'));
	}
}
