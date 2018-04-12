<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class EmployeeFB extends Model
{
	protected $table = 'temployeesfamilybackground';
	protected $fillable = ['EmployeeID','sSurname','sFirstname','sMiddlename','sExtentionname','mMiddlename','sOccupation','sBusinessname','sBusinessaddress','sTel',
	'fSurname','fFirstname','fExtensionname','fMiddlename','mMaidenname','mSurname','mFirstname'];
	protected $primaryKey = 'id';
	public $timestamps = false;
}
