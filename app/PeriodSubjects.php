<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class PeriodSubjects extends Model
{
	protected $table = 'tperiodsubjects';
	protected $fillable = ['EmployeeID','PeriodSectionID','ClassCode','TeacherID'];
	protected $primaryKey = 'ID';
	public $timestamps = false;
}
