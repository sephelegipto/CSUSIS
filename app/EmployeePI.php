<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class EmployeePI extends Model
{
	protected $table = 'temployeespersonalinformation';
	protected $fillable = ['EmployeeID','ExtensionName','DOB','POB','Email','PhoneNumber','Telephone','CivilStatus','Height','Weight',
	'BloodType','GSIS','PAGIBIG','PHILHEALTH','SSS','TIN','AGENCYEMPLOYEENO','ResZipCode','PermZipCode',
	'ResHouseBlockLotNo','ResStreet','ResSubDiv','ResBrngy','ResCity','ResProvince','PermHouseBlockLotNo','PermStreet','PermSubDiv',
	'PermBrngy','PermCity','PermProvince'];
	protected $primaryKey = 'id';
	public $timestamps = false;
}
