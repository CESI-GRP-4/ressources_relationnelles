<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Favorite extends Model {
    use HasFactory;

    protected $table = 'asso_user_favorite';
    protected $primaryKey = ['id_user', 'id_ressource'];
    public $incrementing = false;

    protected $fillable = ['id_user', 'id_ressource'];

    public $timestamps = false;

    public function user(){
        return $this->belongsTo(User::class, 'id_user', 'id_user');
    }

    public function ressource(){
        return $this->belongsTo(Ressource::class, 'id_ressource', 'id_ressource');
    }
}
