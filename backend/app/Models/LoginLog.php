<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class LoginLog extends Model {

    protected $table = 'login_logs';
    protected $fillable = ['id_user', 'login_datetime'];

    public $timestamps = false;
}
