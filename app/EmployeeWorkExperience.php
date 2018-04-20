<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class EmployeeWorkExperience extends Model
{
	protected $table = 'temployeesworkexperiences';
	protected $fillable = ['EmployeeID','InclusiveDateFrom','InclusiveDateTo','Position','Department','MonthlySalary','JobPay','StatusAppointment','GovernmentService'];
	protected $primaryKey = 'ID';
	public $timestamps = false;
}
