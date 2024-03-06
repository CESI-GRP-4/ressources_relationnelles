<?php

namespace App\Utils;

class Utils{

    /**
     * @OA\Schema(
     *     schema="UserData",
     *     type="object",
     *     @OA\Property(property="firstName", type="string", description="User's first name"),
     *     @OA\Property(property="lastName", type="string", description="User's last name"),
     *     @OA\Property(property="email", type="string", format="email", description="User's email address"),
     *     @OA\Property(property="imgURL", type="string", description="URL to the user's profile picture"),
     *     @OA\Property(property="id", type="integer", description="User ID"),
     *     @OA\Property(property="role", type="string", description="User's role name"),
     *     @OA\Property(property="isEmailVerified", type="boolean", description="Indicates if the user's email is verified"),
     *     @OA\Property(property="newUser", type="boolean", description="Indicates if the user is new")
     * )
     */
    public static function getUserData($user){
        return [
            'firstName' => $user->first_name,
            'lastName' => $user->last_name,
            'email' => $user->email,
            'imgURL' => $user->path_picture,
            'id' => $user->id_user,
            'role' => $user->role->name,
        ];
    }

    /**
     * @OA\Schema(
     *     schema="UserDetail",
     *     type="object",
     *     @OA\Property(property="id", type="integer"),
     *     @OA\Property(property="email", type="string"),
     *     @OA\Property(property="firstName", type="string"),
     *     @OA\Property(property="lastName", type="string"),
     *     @OA\Property(property="isEmailVerified", type="boolean"),
     *     @OA\Property(property="imgURL", type="string"),
     *     @OA\Property(property="city", type="string"),
     *     @OA\Property(property="country", type="string"),
     *     @OA\Property(property="countryCode", type="string"),
     *     @OA\Property(property="postalCode", type="string"),
     *     @OA\Property(property="role", type="string"),
     *     @OA\Property(property="createdAt", type="string", format="date-time"),
     *     @OA\Property(property="updatedAt", type="string", format="date-time"),
     *     @OA\Property(property="isBanned", type="boolean"),
     *     @OA\Property(property="newUser", type="boolean")
     * )
     */
    public static function getAllUserData($user){
        // set false if not set
        $isNewUser = session('isNewUser', false);
        $userData = [
            'id' => $user->id_user,
            'email' => $user->email,
            'firstName' => $user->first_name,
            'lastName' => $user->last_name,
            'isEmailVerified' => $user->is_verified,
            'imgURL' => $user->path_picture,
            'role' => $user->role->name,
            'createdAt' => $user->created_at,
            'updatedAt' => $user->updated_at,
            'isBanned' => $user->is_banned,
            'newUser' => $isNewUser,
        ];

        if ($user->country) {
            $userData['country'] = $user->country->name;
            $userData['countryCode'] = $user->country->country_code;
        }

        if ($user->postalCode) {
            $userData['postalCode'] = $user->postalCode->postal_code;
        }

        if ($user->city) {
            $userData['city'] = $user->city->name;
        }

        return $userData;
    }

}
