<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use App\Http\Controllers\Controller;
use App\Services\PeriodSubjectsService;
use Illuminate\Support\Facades\Input;


class AdminCollegeController extends Controller
{
  public function ImportSubjects(PeriodSubjectsService $PeriodSubjectsService, Request $request)
  {
    $SubjectPeriod = $PeriodSubjectsService->ImportSubjects($request, $request->file('file')->getRealPath());
    return view('upload', compact('SubjectPeriod'));
  }

  public function ViewUploadPage($id){
    return view('upload');
  }


}
