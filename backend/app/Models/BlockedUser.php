<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class BlockedUser extends Model {

    protected $table = 'blocked_users';
    protected $primaryKey = 'id_blocked';
    public $timestamps = false;
    protected $fillable = [
        'start_date',
        'end_date',
        'id_user',
    ];
}
