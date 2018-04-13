<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;


use Illuminate\Support\Facades\Input;
use DB;
use App\PeriodSubjects;

class AdminCourseController extends Controller
{
  public function ImportSubjects(Request $request)
  {
    $SubjectPeriod = collect([]);

    if($request->hasFile('file')){
      $path = $request->file('file')->getRealPath();


      $reader = \PhpOffice\PhpSpreadsheet\IOFactory::createReader('Xlsx');
      $reader->setReadDataOnly(TRUE);
      $spreadsheet = $reader->load($path);

      $worksheet = $spreadsheet->getActiveSheet();
// Get the highest row and column numbers referenced in the worksheet
$highestRow = $worksheet->getHighestRow(); // e.g. 10
$highestColumn = $worksheet->getHighestColumn(); // e.g 'F'
$highestColumnIndex = \PhpOffice\PhpSpreadsheet\Cell\Coordinate::columnIndexFromString($highestColumn); // e.g. 5


for ($row = 2; $row <= $highestRow; ++$row) {
  $InputSubjectPeriod = collect([]);
  $details = collect([]);
  for ($col = 1; $col <= 23; ++$col) {
    $value = $worksheet->getCellByColumnAndRow($col, $row)->getValue();
    
    $details->push($value);

  }

  $teacherid =   DB::table('vemployees')->select('ID')->where('FullName', $details[22])->pluck('ID');
  if ($details[3] == NULL){
    break;
  }
  if (isset($teacherid[0]) AND isset($details[3])){
    PeriodSubjects::updateOrCreate(['ClassCode'=>$details[3]], ['TeacherID' => $teacherid[0]] );



    $newCompete = PeriodSubjects::updateOrCreate(['ClassCode'=>$details[3]], ['TeacherID' => $teacherid[0]] );

    $result = DB::table('vperiodsubjects')->where('ClassCode', $details[3])->get();
    $zxc = json_decode($result, true);

    $a = array('test'=>'asd');
    array_push($zxc[0], $a);
    $InputSubjectPeriod = $zxc;




  }else{



    $result = DB::table('vperiodsubjects')->where('ClassCode', $details[3])->get();
    $zxc = json_decode($result, true);

    $a = array('test'=>'asd');
    array_push($zxc[0], $a);
    $InputSubjectPeriod = $zxc;
  }

  $SubjectPeriod->push($InputSubjectPeriod);

}



return view('upload', compact('SubjectPeriod'));
}
}

public function ViewUploadPage($id){
  return view('upload');
}


}
