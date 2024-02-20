<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Laravel\Sanctum\HasApiTokens;
use Tymon\JWTAuth\Contracts\JWTSubject;

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
 *     @OA\Property(property="role", type="string", example="Administrateur"),
 *     @OA\Property(property="isEmailVerified", type="boolean", example=true),
 *     @OA\Property(property="newUser", type="boolean", example=false)
 * )
 */
class User extends Authenticatable implements JWTSubject {
    use HasApiTokens, HasFactory, Notifiable;


    /**
     * The table associated with the model.
     *
     * @var string
     */
    protected $table = 'users';

    /**
     * The primary key associated with the table.
     *
     * @var string
     */
    protected $primaryKey = 'id_user';

    /**
     * The attributes that are mass assignable.
     *
     * @var array<int, string>
     */
    protected $fillable = [
        'email',
        'first_name',
        'last_name',
        'password',
        'is_verified',
        'path_picture',
        'id_city',
        'id_postal_code',
        'id_country',
        'id_role',
        'verification_token',
        'password_reset_token',

    ];

    /**
     * The attributes that should be hidden for serialization.
     *
     * @var array<int, string>
     */
    protected $hidden = [
        'password',
    ];

    /**
     * The attributes that should be cast.
     *
     * @var array<string, string>
     */
    protected $casts = [
        'is_verified' => 'boolean',
    ];

    public function role() {
        return $this->belongsTo(Role::class, 'id_role');
    }

    public function city() {
        return $this->belongsTo(City::class, 'id_city');
    }

    public function country() {
        return $this->belongsTo(Country::class, 'id_country');
    }

    public function postalCode() {
        return $this->belongsTo(PostalCode::class, 'id_postal_code');
    }

    public function blockedUsers(){
        return $this->hasMany(BlockedUser::class, 'id_user');
    }

    public function getJWTIdentifier() {
        return $this->getKey();
    }

    public function getJWTCustomClaims() {
        return [];
    }
}
