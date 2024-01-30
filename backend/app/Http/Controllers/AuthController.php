<?php

namespace App\Http\Controllers;

use App\Models\Role;
use App\Models\User;
use App\Notifications\ResetPass;
use App\Notifications\VerifyEmail;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Str;

class AuthController extends Controller{
    private const DEFAULT_ROLE_ID = 2; // User role
    private const EMAIL_NOT_VERIFIED = 0;


    public function login(Request $request){

        $credentials = $request->validate([
            'email' => 'required|email',
            'password' => 'required'
        ]);
        $remember = $request->input('remember', false);

        if (!Auth::guard('api')->attempt($credentials)) {
            return response()->json(['error' => 'Les informations d\'identification fournies ne sont pas correctes.'], 401);
        }

        // Generation of the JWT token
        $token = Auth::guard('api')->attempt($credentials);

        // Retrieving the authenticated user
        $user = Auth::guard('api')->user();

        return $this->respondWithTokenAndUserData($token, $this->getUserData($user), $remember);
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
        auth()->logout();
        return response(null, 200)->withCookie($cookie);
    }

    protected function respondWithTokenAndUserData($token, $userData, $remember = false){

        $defaultTTL = config('jwt.ttl');
        $minutes = $remember ? $defaultTTL : 0;

        $cookie = cookie('token', $token, $minutes, null, null, false, true);
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

        return response()->json(['message' => 'Email vérifié avec succès'],200);
    }

    public function forgotPassword(){
        $data = request()->validate([
            'email' => 'required|email',
        ]);

        $user = User::where('email', $data['email'])->first();

        $token = Str::random(100);
        $user->password_reset_token = $token;
        $user->save();

        $user->notify(new ResetPass());

        return response()->json(['message' => 'Un email de réinitialisation de mot de passe a été envoyé.'],200);
}

    public function resetPassword(){
        $data = request()->validate([
            'token' => 'required',
            'password' => 'required|min:8',
            'verifyPassword' => 'required|min:8',
        ]);

        if ($data['password'] !== $data['verifyPassword']) return response()->json(['message' => 'Les mots de passe ne correspondent pas'], 403);

        $user = User::where('password_reset_token', $data['token'])->first();

        if (!$user) return response()->json(['message' => 'Token de réinitialisation invalide'], 403);

        $user->password = Hash::make($data['password']);
        $user->password_reset_token = null;
        $user->save();

        return response()->json(['message' => 'Mot de passe réinitialisé avec succès'],200);
    }

}
