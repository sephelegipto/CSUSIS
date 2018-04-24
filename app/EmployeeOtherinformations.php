<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class EmployeeOtherinformations extends Model
{
    protected $table = 'temployeeotherinformation';
	protected $fillable = ['EmployeeID','Skills','Recognition','Organization'];
	protected $primaryKey = 'ID';
	public $timestamps = false;
}
