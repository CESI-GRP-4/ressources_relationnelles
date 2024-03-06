<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class UserHistory extends Model{

    protected $table = 'user_history';
    protected $fillable = ['user_id', 'affected_user_id', 'action', 'modified_column', 'old_value', 'new_value','created_at'];


    public function user() {
        return $this->belongsTo(User::class, 'user_id');
    }
    public function affectedUser() {
        return $this->belongsTo(User::class, 'affected_user_id');
    }
}
