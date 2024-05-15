<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Laravel\Sanctum\HasApiTokens;
use Tymon\JWTAuth\Contracts\JWTSubject;

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
        'ban_until',
        'id_profile_picture',
        'id_city',
        'id_postal_code',
        'id_country',
        'id_role',
        'verification_token',
        'password_reset_token',
        'deleted_at',
    ];
    protected $appends = ['path_picture'];
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
        'is_banned' => 'boolean',
    ];


    public function getPathPictureAttribute() {
        return $this->profilePicture ? $this->profilePicture->url : null;
    }
    public function profilePicture() {
        return $this->belongsTo(ProfilePicture::class, 'id_profile_picture', 'id_profile_picture');
    }

    public function role() {
        return $this->belongsTo(Role::class, 'id_role');
    }

    public function city() {
        return $this->belongsTo(City::class, 'id_city');
    }

    public function setCityByName($city) {
        $city = City::firstOrCreate(['name' => $city]);
        $this->id_city = $city->id_city;
        $this->save();
    }

    public function country() {
        return $this->belongsTo(Country::class, 'id_country');
    }

    public function postalCode() {
        return $this->belongsTo(PostalCode::class, 'id_postal_code');
    }

    public function setPostalCodeByName($postalCode) {
        $postalCode = PostalCode::firstOrCreate(['name' => $postalCode]);
        $this->id_postal_code = $postalCode->id_postal_code;
        $this->save();
    }
    public function favorites() {
        return $this->belongsToMany(Ressource::class, 'asso_user_favorite', 'id_user', 'id_ressource');
    }
    public function bookmarks() {
        return $this->belongsToMany(Ressource::class, 'asso_user_bookmark', 'id_user', 'id_ressource');
    }
    public function getJWTIdentifier() {
        return $this->getKey();
    }

    public function getJWTCustomClaims() {
        return [
            'role' => $this->role->name,
        ];
    }
}
