<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class EmployeeVoluntarywork extends Model
{
    protected $table = 'temployeesvoluntarywork';
	protected $fillable = ['EmployeeID','NameOfOrg','InclusiveDateFrom','InclusiveDateTo','NoOfHours','Position'];
	protected $primaryKey = 'ID';
	public $timestamps = false;
}
