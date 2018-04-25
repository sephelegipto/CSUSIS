<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class EmployeeOtherQuestions extends Model
{
    protected $table = 'temployeesotherquestions';
	protected $fillable = ['EmployeeID','Question1','Question2','Question3','Question4','Question5','Question6','Question7','Question8','Question9',
	'Question10','Question11','Question12','Remark1','Remark2','Remark3','Remark4','Remark5','Remark6',
	'Remark7','Remark8','Remark9','Remark10','Remark11','Remark12'];
	protected $primaryKey = 'ID';
	public $timestamps = false;
}
