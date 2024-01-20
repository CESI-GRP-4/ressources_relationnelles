<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Symfony\Component\HttpFoundation\Cookie;

class AuthController extends Controller
{
    public function login(Request $request)
    {
        // Validation des données de requête
        $credentials = $request->validate([
            'email' => 'required|email',
            'password' => 'required'
        ]);

        // Tentative de connexion
        if (!Auth::guard('api')->attempt($credentials)) {
            return response()->json(['error' => 'Les informations d\'identification fournies ne sont pas correctes.'], 401);
        }

        // Génération du token JWT
        $token = Auth::guard('api')->attempt($credentials);

        // Réponse avec le token en cookie HTTP-only
        return $this->respondWithToken($token);
    }

    public function logout()
    {
        // Supprimer le cookie en le mettant à expiration dans le passé
        $cookie = \Cookie::forget('token');

        // Vous pouvez également invalider le token JWT ici si nécessaire
        // auth()->logout();

        return response()->json(['message' => 'Déconnexion réussie'])->withCookie($cookie);
    }


    protected function respondWithToken($token)
    {
        $cookie = cookie('token', $token, 60, null, null, false, true); // 160 minutes, HTTP-only ! put var in env?

        return response()->json(['success' => true])->withCookie($cookie);
    }
}
