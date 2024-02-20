<?php

namespace App\Utils;

use App\Models\Role;

class Utils{
    public static function getUserData($user){
        // Default value for isNewUser is false
        $isNewUser = session('isNewUser', false);

        return [
            'firstName' => $user->first_name,
            'lastName' => $user->last_name,
            'email' => $user->email,
            'imgURL' => $user->path_picture,
            'id' => $user->id_user,
            'role' => $user->role->name,
            'isEmailVerified' => $user->is_verified,
            'newUser' => $isNewUser,
        ];
    }

    public static function getAllUserData($user){
        // set false if not set
        $isNewUser = session('isNewUser', false);
        return [
            'id' => $user->id_user,
            'email' => $user->email,
            'firstName' => $user->first_name,
            'lastName' => $user->last_name,
            'isEmailVerified' => $user->is_verified,
            'imgURL' => $user->path_picture,
            'city' => $user->city->name,
            'country' => $user->country->name,
            'countryCode' => $user->country->country_code,
            'postalCode' => $user->postalCode->postal_code,
            'role' => $user->role->name,
            'createdAt' => $user->created_at,
            'updatedAt' => $user->updated_at,
            'newUser' => $isNewUser,
        ];
    }

}
