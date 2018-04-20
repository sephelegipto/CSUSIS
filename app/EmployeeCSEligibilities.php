<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class EmployeeCSEligibilities extends Model
{
	protected $table = 'temployeecseligibilities';
	
	protected $fillable = ['EmployeeID', 'CareerService','Rating','DateOfExamination','PlaceOfExamination','LicenseNumber','DateValidity'];
	protected $primaryKey = 'ID';
	public $timestamps = false;
}
