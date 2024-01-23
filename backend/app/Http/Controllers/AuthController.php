<?php

namespace App\Http\Controllers;

use App\Models\City;
use App\Models\Country;
use App\Models\PostalCode;
use App\Models\Role;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Symfony\Component\HttpFoundation\Cookie;

class AuthController extends Controller
{
    public function login(Request $request)
    {
        // Request data validation
        $credentials = $request->validate([
            'email' => 'required|email',
            'password' => 'required'
        ]);

        // Attempt to login
        if (!Auth::guard('api')->attempt($credentials)) {
            return response()->json(['error' => 'Les informations d\'identification fournies ne sont pas correctes.'], 401);
        }

        // Generation of the JWT token
        $token = Auth::guard('api')->attempt($credentials);

        // Retrieving the authenticated user
        $user = Auth::guard('api')->user();

        $userData = [
            'firstName' => $user->first_name,
            'lastName' => $user->last_name,
            'email' => $user->email,
            'imgURL' => $user->path_picture,
            'id' => $user->id_user,
            'role' => $this->getRoleName($user->id_role),
            'isEmailVerified' => $user->is_verified,
            'city' => $this->getCityName($user->id_city),
            'country' => $this->getCountryName($user->id_country),
            'postalCode' => $this->getPostalCode($user->id_postal_code),
        ];

        return $this->respondWithTokenAndUserData($token, $userData);
    }

    public function logout()
    {
        // Delete the cookie by setting its expiration to the past
        $cookie = \Cookie::forget('token');

        // Vous pouvez invalider le token JWT ici
        // auth()->logout();

        return response(null, 200)->withCookie($cookie);
    }


    protected function respondWithTokenAndUserData($token, $userData)
    {
        $cookie = cookie('token', $token, 60, null, null, false, true);
        return response()->json(['user' => $userData])->withCookie($cookie);
    }

    protected function getRoleName($id_role){
        $role = Role::find($id_role);
        return $role ? $role->name : null;
    }

    protected function getCityName($id_city){
        $city = City::find($id_city);
        return $city ? $city->name : null;
    }

    protected function getCountryName($id_country){
        $country = Country::find($id_country);
        return $country ? $country->name : null;
    }

    protected function getPostalCode($id_postal_code){
        $postalCode = PostalCode::find($id_postal_code);
        return $postalCode ? $postalCode->postal_code : null;
    }

}
