<?php
namespace App;
use Illuminate\Notifications\Notifiable;
use Illuminate\Foundation\Auth\User as Authenticatable;
class tuser extends Authenticatable
{
    use Notifiable;
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $guard = 'tuser';

    protected $fillable = [
        'id', 'LoginID', 'password', 'UserTypeID', 'course_id'
    ];
    /**
     * The attributes that should be hidden for arrays.
     *
     * @var array
     */
    protected $hidden = [
        'password', 'remember_token',
    ];
    public function role(){
        return $this->hasOne('App\Role', 'ID', 'UserTypeID');
    }
    public function checkIfUserHasRole($need_role)
    {
        return (strtolower($need_role)==strtolower($this->role->Description) ? true : null);
    }
    public function hasRole($roles)
    {
        if (is_array($roles))
        {
            foreach ($roles as $need_role) {
                if ($this->checkIfUserHasRole($need_role))
                {
                    return true;
                }
            }
        } else {
                return $this->checkIfUserHasRole($roles);
        }
        return false;
    }
}