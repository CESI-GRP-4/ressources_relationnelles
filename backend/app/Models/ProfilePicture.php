<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ProfilePicture extends Model {
    protected $table = 'profile_pictures';
    protected $primaryKey = 'id_profile_picture';
    public $timestamps = false;

    protected $fillable = [
        'name',
        'url'
    ];
}
