<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class EmployeeLearningDevelopments extends Model
{
    protected $table = 'temployeeslearningandevelopment';
	protected $fillable = ['EmployeeID','Title','InclusiveDateFrom','InclusiveDateTo','NoOfHours','TypeOfLD','ConductedBy'];
	protected $primaryKey = 'ID';
	public $timestamps = false;
}
