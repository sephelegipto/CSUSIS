<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Role extends Model
{
    protected $table = 'tusertypes';
    protected $fillable = ['Description'];
    protected $primaryKey = 'ID';
    public $timestamps = false;

    public function tusers()
    {
    	$this->hasMany('App\User', 'ID', 'ID');
    }
}
