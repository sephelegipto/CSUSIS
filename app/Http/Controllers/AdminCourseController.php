<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;


use Illuminate\Support\Facades\Input;

class AdminCourseController extends Controller
{
    public function ImportSubjects(Request $request)
    {


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

echo '<table>' . "\n";
for ($row = 2; $row <= $highestRow; ++$row) {
    echo '<tr>' . PHP_EOL;
$details = collect([]);
    for ($col = 1; $col <= 23; ++$col) {
        $value = $worksheet->getCellByColumnAndRow($col, $row)->getValue();
  
        $details->push($value);
    }


    $id = DB::table('tperiodsubjects')->insertGetId(
      ['ClassCode' => $details[3] ,
       'ClassCode' => 'john@example.com',
       'ClassCode' => 'john@example.com',
       'ClassCode' => 'john@example.com'
   ]
    );

dd($details);
    echo '</tr>' . PHP_EOL;

}
echo '</table>' . PHP_EOL;



}
}

public function ViewUploadPage($id){
    return view('upload');
}


}
