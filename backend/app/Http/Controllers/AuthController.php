<?php

namespace App\Http\Controllers;

use App\Models\City;
use App\Models\Country;
use App\Models\PostalCode;
use App\Models\Role;
use App\Models\User;
use App\Notifications\VerifyEmail;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Str;
use Symfony\Component\HttpFoundation\Cookie;

class AuthController extends Controller{
    private const DEFAULT_ROLE_ID = 2; // User role
    private const EMAIL_NOT_VERIFIED = 0;


    public function login(Request $request){
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

        return $this->respondWithTokenAndUserData($token, $this->getUserData($user));
    }

    public function signup(Request $request){

        $data = $request->validate([
            'email' => 'required|email',
            'firstName' => 'required',
            'lastName' => 'required',
            'password' => 'required|min:8',
        ]);

        if (User::where('email', $data['email'])->exists()) {
            return response()->json(['error' => "L'adresse email est déjà utilisée."], 401);
        }
        $verificationToken = Str::random(100);

        $user = User::create([
            'email' => $data['email'],
            'first_name' => $data['firstName'],
            'last_name' => $data['lastName'],
            'password' => Hash::make($data['password']),
            'id_role' => self::DEFAULT_ROLE_ID,
            'is_verified' => self::EMAIL_NOT_VERIFIED,
            'verification_token' => $verificationToken,
        ]);

        $user->notify(new VerifyEmail());

        return $this->login($request);
    }

    public function logout(){
        $cookie = \Cookie::forget('token');

        // Vous pouvez invalider le token JWT ici
        // auth()->logout();

        return response(null, 200)->withCookie($cookie);
    }


    protected function respondWithTokenAndUserData($token, $userData){
        $cookie = cookie('token', $token, 60, null, null, false, true);
        return response()->json(['user' => $userData])->withCookie($cookie);
    }

    protected function getUserData($user){
        return [
            'firstName' => $user->first_name,
            'lastName' => $user->last_name,
            'email' => $user->email,
            'imgURL' => $user->path_picture,
            'id' => $user->id_user,
            'role' => $this->getRoleName($user->id_role),
            'isEmailVerified' => $user->is_verified,
        ];
    }

    protected function getRoleName($id_role){
        $role = Role::find($id_role);
        return $role ? $role->name : null;
    }

    public function verifyEmail(Request $request)
    {
        $token = $request->input('token');

        $user = User::where('verification_token', $token)->first();

        if (!$user) {
            return response()->json(['message' => 'Token de vérification invalide'], 403);
        }

        $user->is_verified = true;
        $user->verification_token = null;
        $user->save();

        return response()->json(['message' => 'Email vérifié avec succès']);
    }

}
