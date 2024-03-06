<?php

namespace App\Http\Controllers;

use App\Models\LoginLog;
use App\Models\Role;
use App\Models\User;
use App\Notifications\ResetPass;
use App\Notifications\VerifyEmail;
use App\Utils\Utils;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Str;

class AuthController extends Controller{
    private const DEFAULT_ROLE_ID = 4; // User role
    private const EMAIL_NOT_VERIFIED = 0;
    private const IS_NOT_BANNED = 0;
    /**
     * @OA\Post(
     *     path="/login",
     *     tags={"Authentication"},
     *     summary="Log in to the application",
     *     operationId="login",
     *     @OA\RequestBody(
     *         required=true,
     *         description="User's login credentials",
     *         @OA\JsonContent(
     *             required={"email", "password"},
     *             @OA\Property(property="email", type="string", format="email", example="user@example.com"),
     *             @OA\Property(property="password", type="string", format="password", example="password123"),
     *             @OA\Property(property="remember", type="boolean", example=false)
     *         ),
     *     ),
     *     @OA\Response(
     *         response=200,
     *         description="Successful login",
     *         @OA\JsonContent(
     *             @OA\Property(property="user", type="object", ref="#/components/schemas/UserData"),
     *             @OA\Property(property="remember", type="boolean", example=false)
     *         )
     *     ),
     *     @OA\Response(
     *         response=401,
     *         description="Invalid credentials",
     *         @OA\JsonContent(
     *             @OA\Property(property="message", type="string", example="Les informations d'identification fournies ne sont pas correctes.")
     *         )
     *     ),
     *     @OA\Response(
     *         response=403,
     *         description="Account banned",
     *         @OA\JsonContent(
     *             @OA\Property(property="message", type="string", example="Votre compte est banni.")
     *         )
     *     )
     * )
     */
    public function login(Request $request){
        $credentials = $request->validate([
            'email' => 'required|email',
            'password' => 'required'
        ]);
        $remember = $request->input('remember', false);

        if (!Auth::guard('api')->attempt($credentials)) {
            return response()->json(['message' => 'Les informations d\'identification fournies ne sont pas correctes.'], 401);
        }

        $user = User::where('email', $request->email)->first();
        if ($user->is_banned) {
            return response()->json(['message' => 'Votre compte est banni.'], 403);
        }

        // Generation of the JWT token
        $token = Auth::guard('api')->attempt($credentials);

        // Retrieving the authenticated user
        $user = Auth::guard('api')->user();

        // Log connection
        LoginLog::create([ 'id_user' => $user->id_user]);

        return $this->respondWithTokenAndUserData($token,
            ['user' => Utils::getAllUserData($user),
            'remember' => $remember]);
    }

    /**
     * @OA\Post(
     *     path="/signup",
     *     tags={"Authentication"},
     *     summary="Create a new user account",
     *     operationId="signup",
     *     @OA\RequestBody(
     *         required=true,
     *         description="User's registration data",
     *         @OA\JsonContent(
     *             required={"email", "firstName", "lastName", "password"},
     *             @OA\Property(property="email", type="string", format="email", example="user@example.com"),
     *             @OA\Property(property="firstName", type="string", example="John"),
     *             @OA\Property(property="lastName", type="string", example="Doe"),
     *             @OA\Property(property="password", type="string", format="password", example="password123")
     *         ),
     *     ),
     *     @OA\Response(
     *         response=200,
     *         description="Successful registration and user login",
     *         @OA\JsonContent(
     *             @OA\Property(property="user", type="object", ref="#/components/schemas/UserData"),
     *         )
     *     ),
     *     @OA\Response(
     *         response=401,
     *         description="Email address already in use",
     *         @OA\JsonContent(
     *             @OA\Property(property="message", type="string", example="L'adresse email est déjà utilisée.")
     *         )
     *     ),
     * )
     */
    public function signup(Request $request){

    $data = $request->validate([
        'email' => 'required|email',
        'firstName' => 'required',
        'lastName' => 'required',
        'password' => 'required|min:8',
    ]);

    if (User::where('email', $data['email'])->exists()) {
        return response()->json(['message' => "L'adresse email est déjà utilisée."], 401);
    }
    $verificationToken = Str::random(100);

    $user = User::create([
        'email' => $data['email'],
        'first_name' => $data['firstName'],
        'last_name' => $data['lastName'],
        'password' => Hash::make($data['password']),
        'id_role' => self::DEFAULT_ROLE_ID,
        'is_verified' => self::EMAIL_NOT_VERIFIED,
        'is_banned' => self::IS_NOT_BANNED,
        'verification_token' => $verificationToken,
    ]);

    $user->notify(new VerifyEmail());

    session(['isNewUser' => true]);

    return $this->login($request);
}

    /**
     * @OA\Post(
     *     path="/logout",
     *     tags={"Authentication"},
     *     summary="Log out of the application",
     *     operationId="logout",
     *     security={{"bearerAuth":{}}},
     *     @OA\Response(
     *          response=200,
     *          description="Successful logout",
     *          @OA\JsonContent(
     *              @OA\Property(property="message", type="string", example="null")
     *          )
     *      ),
     *     @OA\Response(
     *          response=401,
     *          description="Invalid verification token",
     *          @OA\JsonContent(
     *              @OA\Property(property="message", type="string", example="Token de vérification invalide")
     *          )
     *      )
     * )
     */
    public function logout(){
        try {
            auth()->logout();
            $cookie = \Cookie::forget('token');
            return response(null, 200)->withCookie($cookie);
        } catch (\Exception $e) {
            return response()->json(['message' => 'Token de vérification invalide'], 401);
        }
    }


    protected function respondWithTokenAndUserData($token, $data = []){

        $defaultTTL = config('jwt.ttl');
        $minutes = $data['remember'] ? $defaultTTL : 0;

        $cookie = cookie('token', $token, $minutes, null, null, false, true);
        return response()->json(['user' => $data['user'],'newUser' => $data['newUser'] ?? false])->withCookie($cookie);
    }

    /**
     * @OA\Post(
     *     path="/verifyUser",
     *     tags={"Authentication"},
     *     summary="Verify the user's authentication status",
     *     operationId="verifyUser",
     *     security={{"bearerAuth":{}}},
     *     @OA\Response(
     *          response=200,
     *          description="User is authenticated",
     *          @OA\JsonContent(
     *              @OA\Property(property="user", type="object", ref="#/components/schemas/UserData"),
     *          )
     *      ),
     *     @OA\Response(
     *          response=401,
     *          description="User is not authenticated",
     *          @OA\JsonContent(
     *              @OA\Property(property="error", type="string", example="Utilisateur non authentifié")
     *          )
     *      )
     * )
     */
    public function verifyUser(){
        $user = auth()->user();
        if (!$user) return response()->json(['error' => 'Utilisateur non authentifié'], 401);
        return response()->json(['user' => Utils::getUserData($user)]);
    }

    /**
     * @OA\Post(
     *     path="/email/verify",
     *     tags={"Authentication"},
     *     summary="Verify the user's email address",
     *     operationId="verifyEmail",
     *     @OA\RequestBody(
     *         required=true,
     *         description="Verification token for email verification",
     *         @OA\JsonContent(
     *             required={"token"},
     *             @OA\Property(property="token", type="string", example="your_verification_token")
     *         ),
     *     ),
     *     @OA\Response(
     *         response=200,
     *         description="Email successfully verified",
     *         @OA\JsonContent(
     *             @OA\Property(property="message", type="string", example="Email vérifié avec succès")
     *         )
     *     ),
     *     @OA\Response(
     *         response=403,
     *         description="Invalid verification token",
     *         @OA\JsonContent(
     *             @OA\Property(property="message", type="string", example="Token de vérification invalide")
     *         )
     *     ),
     * )
     */
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

    /**
     * @OA\Post(
     *     path="/forgot-password/send-mail",
     *     tags={"Authentication"},
     *     summary="Send a password reset email; if the email does not exist, still send an email to prevent brute force attacks",
     *     operationId="forgotPassword",
     *     @OA\RequestBody(
     *         required=true,
     *         description="Email to send the password reset link",
     *         @OA\JsonContent(
     *             required={"email"},
     *             @OA\Property(property="email", type="string", format="email", example="user@example.com")
     *         ),
     *     ),
     *     @OA\Response(
     *         response=200,
     *         description="Password reset email sent",
     *         @OA\JsonContent(
     *             @OA\Property(property="message", type="string", example="Un email de réinitialisation de mot de passe a été envoyé.")
     *         )
     *     )
     * )
     */
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

    /**
     * @OA\Post(
     *     path="/forgot-password/reset",
     *     tags={"Authentication"},
     *     summary="Reset user's password",
     *     operationId="resetPassword",
     *     @OA\RequestBody(
     *         required=true,
     *         description="Data required for password reset",
     *         @OA\JsonContent(
     *             required={"token", "password", "verifyPassword"},
     *             @OA\Property(property="token", type="string", example="your_reset_token"),
     *             @OA\Property(property="password", type="string", format="password", example="newpassword123"),
     *             @OA\Property(property="verifyPassword", type="string", format="password", example="newpassword123")
     *         ),
     *     ),
     *     @OA\Response(
     *         response=200,
     *         description="Password successfully reset",
     *         @OA\JsonContent(
     *             @OA\Property(property="message", type="string", example="Mot de passe réinitialisé avec succès")
     *         )
     *     ),
     *     @OA\Response(
     *          response=403,
     *          description="Password mismatch or invalid reset token",
     *          @OA\JsonContent(
     *              @OA\Property(property="message", type="string", example="Les mots de passe ne correspondent pas | Token de réinitialisation invalide")
     *          )
     *      )
     *
     *
     * )
     */
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
