<?php
namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Bookmark extends Model {
    use HasFactory;

    protected $table = 'asso_user_bookmark';
    protected $primaryKey = ['id_user', 'id_ressource']; // Clé primaire composite
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
