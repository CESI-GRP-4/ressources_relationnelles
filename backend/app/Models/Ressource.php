<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Ressource extends Model {

    use HasFactory;

    /**
     * The table associated with the model.
     *
     * @var string
     */
    protected $table = 'ressources';

    /**
     * The primary key associated with the table.
     *
     * @var string
     */
    protected $primaryKey = 'id_ressource';

    /**
     * The attributes that are mass assignable.
     *
     * @var array<int, string>
     */
    protected $fillable = [
        'label',
        'description',
        'content',
        'id_category',
        'is_public',
        'view_count',
        'id_user',
        'id_status',
        'id_type',
        'file',
        'updated_at',
        'created_at',
    ];

//    public function category()
//    {
//       // ! Weird, Category model doesnt exist
//       // TODO: Look at it later
//        return $this->belongsTo(Category::class, 'id_category');
//    }
}
