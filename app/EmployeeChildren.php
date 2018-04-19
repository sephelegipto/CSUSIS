<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class EmployeeChildren extends Model
{
	protected $table = 'temployeechildrens';
	protected $fillable = ['ID','EmployeeID','Name','Birthday'];
	protected $primaryKey = 'ID';
	public $timestamps = false;
}
