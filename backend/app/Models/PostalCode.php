<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class PostalCode extends Model
{
    protected $table = 'postal_codes';
    protected $primaryKey = 'id_postal_code';
    public $timestamps = false;

    protected $fillable = ['postal_code'];
}
