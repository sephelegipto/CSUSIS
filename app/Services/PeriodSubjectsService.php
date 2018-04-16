<?php
namespace App\Services;
use DB;
use App\PeriodSubjects;
use App\PeriodSchedules;
class PeriodSubjectsService
{

	public static function ImportSubjects($request, $file){
		$SubjectPeriod = collect([]);
		

		if (!is_null($file)){
			$reader = \PhpOffice\PhpSpreadsheet\IOFactory::createReader('Xlsx');
			$reader->setReadDataOnly(TRUE);
			$spreadsheet = $reader->load($file);

			$worksheet = $spreadsheet->getActiveSheet();

			$highestRow = $worksheet->getHighestRow(); 
			$highestColumn = $worksheet->getHighestColumn(); 
			$highestColumnIndex = \PhpOffice\PhpSpreadsheet\Cell\Coordinate::columnIndexFromString($highestColumn); 
			$InputSubjectPeriod = collect([]);

			for ($row = 2; $row <= $highestRow; ++$row) {
				
				$details = collect([]);
				for ($col = 1; $col <= 23; ++$col) {
					$value = $worksheet->getCellByColumnAndRow($col, $row)->getValue();
					$details->push($value);
				}

				$ClassCode = $details[3];
				$TeacherName = $details[22];

				$TeacherID =   DB::table('vemployees')->select('ID')->where('FullName', $TeacherName)->pluck('ID');



				if(count($TeacherID)){
					$subjects = self::UpdateTeacher($ClassCode, $TeacherID[0]);
					
					$PeriodSubjectID = $subjects[1];

					
					$StartLec = $details[14];
					$EndLec = $details[15];
					$DayLec = $details[16];
					$RoomLec = $details[17];
					$ScheduleLec = self::UpdateSchedule($PeriodSubjectID, $StartLec, $EndLec, 0);

					$data = $ScheduleLec->toArray();
					array_push($subjects[0][0], $data);
					$StartLab = $details[18];
					$EndLab = $details[19];
					$DayLab = $details[20];
					$RoomLab = $details[21];
					$ScheduleLab = self::UpdateSchedule($PeriodSubjectID, $StartLab, $EndLab, 1);
					

					$SubjectPeriod->push($subjects[0]);
				}

				
			}
		}
		dd($SubjectPeriod);
	}
	public static function UpdateTeacher($ClassCode, $TeacherID ){
		PeriodSubjects::updateOrCreate(['ClassCode'=>$ClassCode], ['TeacherID' => $TeacherID]);
		$result = DB::table('vperiodsubjects')->where('ClassCode', $ClassCode)->get();
		$id = $result[0]->ID;
		$zxc = json_decode($result, true);
		$a = array('test'=>'Success');
		array_push($zxc[0], $a);

		return array($zxc, $id);
	}

	public static function UpdateSchedule($PeriodSubjectID, $Start, $End, $SessionType){
		 $data = PeriodSchedules::updateOrCreate(['PeriodSubjectID'=>$PeriodSubjectID, 'SessionType' => $SessionType], ['PeriodSubjectID' => $PeriodSubjectID, 'Start' => $Start, 'End' => $End, 'SessionType' => $SessionType]);
	$sched = PeriodSchedules::find($data->ID);
		return $sched;
		
	}


}