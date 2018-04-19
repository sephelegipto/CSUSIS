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

				if (!empty($details[0])){
					if (!empty($TeacherID[0]) ){
						
						$subjects = self::UpdateTeacher($ClassCode, $TeacherID[0]);

						$PeriodSubjectID = $subjects[1];


						$StartLec = $details[14];
						$EndLec = $details[15];
						$DayLec = $details[16];
						$RoomLec = $details[17];
						$RoomID =   DB::table('trooms')->select('ID')->where('RoomCode', $RoomLec)->pluck('ID');
						$ScheduleLec = self::UpdateSchedule($PeriodSubjectID, $StartLec, $EndLec, 0, $RoomID[0], $DayLec);


						$data = $ScheduleLec->toArray();
						array_push($subjects[0][0], $data);
						$StartLab = $details[18];
						$EndLab = $details[19];
						$DayLab = $details[20];
						$RoomLab = $details[21];
						$RoomID =   DB::table('trooms')->select('ID')->where('RoomCode', $RoomLab)->pluck('ID');
						if ($StartLab != ''){
							$ScheduleLab = self::UpdateSchedule($PeriodSubjectID, $StartLab, $EndLab, 1, $RoomID[0], $DayLab);
						}



						$SubjectPeriod->push($subjects[0]);
					} else {

						$subjects = self::UpdateTeacher($ClassCode, 0);

						$PeriodSubjectID = $subjects[1];


						$StartLec = $details[14];
						$EndLec = $details[15];
						$DayLec = $details[16];
						$RoomLec = $details[17];
						$RoomID =   DB::table('trooms')->select('ID')->where('RoomCode', $RoomLec)->pluck('ID');
						$ScheduleLec = self::UpdateSchedule($PeriodSubjectID, $StartLec, $EndLec, 0, $RoomID[0], $DayLec);


						$data = $ScheduleLec->toArray();
						array_push($subjects[0][0], $data);
						$StartLab = $details[18];
						$EndLab = $details[19];
						$DayLab = $details[20];
						$RoomLab = $details[21];
						$RoomID =   DB::table('trooms')->select('ID')->where('RoomCode', $RoomLab)->pluck('ID');
						if ($StartLab != ''){
							$ScheduleLab = self::UpdateSchedule($PeriodSubjectID, $StartLab, $EndLab, 1, $RoomID[0], $DayLab);
						}


						$SubjectPeriod->push($subjects[0]);
					}
				}



			}
		}
		return $SubjectPeriod;
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

	public static function UpdateSchedule($PeriodSubjectID, $Start, $End, $SessionType, $RoomID, $Day){
		$data = PeriodSchedules::updateOrCreate(['PeriodSubjectID'=>$PeriodSubjectID, 'SessionType' => $SessionType], ['PeriodSubjectID' => $PeriodSubjectID, 'Start' => $Start, 'End' => $End, 'SessionType' => $SessionType, 'RoomID' => $RoomID, 'Day' => $Day]);
		$sched = PeriodSchedules::find($data->ID);
		return $sched;

	}


}