<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

// Add other properties of the Ressource model here
/**
 * @OA\Schema(
 *     schema="RessourceDetail",
 *     type="object",
 *     description="Detailed information about a resource",
 *     @OA\Property(property="id", type="integer", description="The ID of the resource"),
 *     @OA\Property(property="title", type="string", description="The title of the resource"),
 *     @OA\Property(property="description", type="string", description="The description of the resource"),
 *
 *
 *
 *     @OA\Property(property="createdAt", type="string", format="date-time", description="The creation date of the resource"),
 *     @OA\Property(property="updatedAt", type="string", format="date-time", description="The last update date of the resource"),
 * )
 */
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
