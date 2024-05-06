<?php
namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Comment extends Model
{
    protected $table = 'comments';
    protected $primaryKey = 'id_comment';

    protected $fillable = [
        'comment',
        'created_at',
        'id_parent',
        'id_ressource',
        'id_user',
        'id_status'
    ];

    public $timestamps = false;

    protected $dates = ['created_at'];

    /**
     * Relation pour obtenir l'utilisateur qui a créé le commentaire.
     */
    public function user() {
        return $this->belongsTo(User::class, 'id_user', 'id_user');
    }

    /**
     * Relation récursive pour les commentaires enfants.
     * Cela permet de récupérer tous les commentaires qui sont des réponses à ce commentaire.
     */
    public function replies() {
        return $this->hasMany(Comment::class, 'id_parent', 'id_comment');
    }

    /**
     * Relation pour obtenir le commentaire parent s'il existe.
     * Cela permet de remonter au commentaire initial auquel celui-ci répond.
     */
    public function parentComment() {
        return $this->belongsTo(Comment::class, 'id_parent_comment', 'id_comment');
    }
}
