<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class PeriodSchedules extends Model
{
	protected $table = 'tperiodschedules';
	protected $fillable = ['ID','PeriodSubjectID','Day','Start','End', 'RoomID', 'SessionType'];
	protected $primaryKey = 'ID';
	public $timestamps = false;
}
