<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use DB;
class AdminController extends Controller
{
	public function ViewCourse(){
		$courses = DB::select("call spLibraryViewAllORSearch('courses','')");

		return view('admin/courses/courses', compact('courses'));
	}

		public function ViewEmployee(){
		$employees = DB::select("call spLibraryViewAllORSearch('Employees','')");

		return view('admin/employee/employee', compact('employees'));
	}

	public function ViewCollege(){
		$colleges = DB::select("call spLibraryViewAllORSearch('Colleges','')");

		return view('admin/college/college', compact('colleges'));
	}

	public function ViewBuilding(){
		$buildings = DB::select("call spLibraryViewAllORSearch('Buildings','')");

		return view('admin/building/building', compact('buildings'));
	}

	public function ViewStudent(){
		$students = DB::select("call spStudentslistViewAllORSearch('Student List','')");

		return view('admin/student/studentlist', compact('students'));
	}

	public function ViewCurriculumList(){
		$curriculums = DB::select("call spLibraryViewAllORSearch('Curriculums','')");
		return view('admin/curriculum/CurriculumList', compact('curriculums'));

	}
}
