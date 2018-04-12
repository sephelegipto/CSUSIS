<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class EmployeeReferences extends Model
{
	protected $table = 'temployeesreferences';
	protected $fillable = ['EmployeeID','Name','Address','ContactNumber'];
	protected $primaryKey = 'ID';
	public $timestamps = false;
}
