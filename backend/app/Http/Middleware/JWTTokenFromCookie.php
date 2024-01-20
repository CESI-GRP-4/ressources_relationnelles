<?php

namespace App\Http\Middleware;

use Closure;

class JWTTokenFromCookie
{
    public function handle($request, Closure $next)
    {
        // Extraire le token du cookie
        $token = $request->cookie('token');

        // Si un token est présent, l'ajouter à l'en-tête de la requête
        if ($token) {
            $request->headers->set('Authorization', 'Bearer ' . $token);
        }

        return $next($request);
    }
}
