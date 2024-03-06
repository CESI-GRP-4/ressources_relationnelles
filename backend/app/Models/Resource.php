<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Resource extends Model
{
    use HasFactory;


/**
 * @OA\Schema(
 *     schema="User",
 *     type="object",
 *     title="User",
 *     description="Schéma d'un utilisateur",
 *     @OA\Property(property="firstName", type="string", example="John"),
 *     @OA\Property(property="lastName", type="string", example="Doe"),
 *     @OA\Property(property="email", type="string", format="email", example="john.doe@example.com"),
 *     @OA\Property(property="imgURL", type="string", example="http://example.com/image.jpg"),
 *     @OA\Property(property="id", type="integer", format="int64", example=1),
 *     @OA\Property(property="role", type="string", example="Admin"),
 *     @OA\Property(property="isEmailVerified", type="boolean", example=true),
 *     @OA\Property(property="newUser", type="boolean", example=false)
 * )
 */

    /**
     * The table associated with the model.
     *
     * @var string
     */
    protected $table = 'resources';

    /**
     * The primary key associated with the table.
     *
     * @var string
     */
    protected $primaryKey = 'id_resource';

    /**
     * The attributes that are mass assignable.
     *
     * @var array<int, string>
     */
    protected $fillable = [
        'id_resource',
        'label',
        'description',
        'content',
        'is_public',
        'view_count',
        'id_user',
        'id_category',
        'id_status',
        ];

    // public function role()
    // {
    //     return $this->belongsTo(Role::class, 'id_role');
    // }
    // public function getJWTIdentifier() {
    //     return $this->getKey();
    // }

    // public function getJWTCustomClaims() {
    //     return [
    //         'role' => $this->role->name,
    //     ];
    // }
}