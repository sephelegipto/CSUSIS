<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Employees extends Model
{
	protected $table = 'temployees';
	protected $guarded = ['EmployeeID'];
	protected $fillable = ['LastName','FirstName','MiddleName'];
	protected $primaryKey = 'ID';
	public $timestamps = false;
}
