import { NextRequest, NextResponse } from 'next/server'

const routeForEveryone = ['/', /^\/ressource\/\d+$/, '/verification-mail'];

// Routes accessible without authentication
const routeWithoutAuth = [
       '/connexion',
       '/mot-de-passe-oublie',
       '/reinitialisation-mot-de-passe'
];

// Routes accessible to authenticated users (Utilisateur)
const routeWithUserAuth = [
       ...routeForEveryone,
       '/categories',
       '/mes-ressources',
       '/mes-favoris',
       '/profil',
       '/creer-ressource',
       '/a-regarder-plus-tard',
       /^\/editer-ressource\/\d+$/,
       /^\/categorie\/\d+$/
];

// Routes accessible to Moderators (Moderateur)
const routeForModerator = [
       ...routeWithUserAuth,
       '/tableau-de-bord',
       '/gestion-ressources/ressources-acceptees',
       '/gestion-ressources/ressources-en-attente',
       '/gestion-ressources/ressources-refusees',
       '/gestion-ressources/ressources-bloquees',
       '/gestion-ressources/ressources-desactivees',

       '/gestion-commentaires/commentaires-en-attente',
       '/gestion-commentaires/commentaires-acceptes',
       '/gestion-commentaires/commentaires-refuses',
       '/statistiques/connexions',
       '/statistiques/ressources',
       '/statistiques/categories',
];

// Routes accessible to Admins (Administrateur)
const routeForAdmin = [
       ...routeForModerator,
       '/gestion-utilisateurs',
       '/gestion-utilisateurs-historique',
       '/gestion-categories',
];

// Routes accessible to Super SuperAdmins (SuperAdministrateur)
const routeForSuperAdmin = [
       ...routeForAdmin,
];

function decodeBase64(str: string): string {
       const base64 = str.replace(/-/g, '+').replace(/_/g, '/');
       return Buffer.from(base64, 'base64').toString('utf-8');
}

function parseJwt(token: string): any {
       const base64Url = token.split('.')[1];
       if (!base64Url) return null;
       return JSON.parse(decodeBase64(base64Url));
}

function getUserRole(req: NextRequest): string | null {
       const token = req.cookies.get('token');
       if (!token) return null;

       try {
              const decodedToken = parseJwt(token.value);
              return decodedToken.role;
       } catch (error) {
              return null;
       }
}

export const config = {
       matcher: [
              /*
               * Match all request paths except for the ones starting with:
               * - api (API routes)
               * - _next/static (static files)
               * - _next/image (image optimization files)
               * - favicon.ico (favicon file)
               */
              '/((?!api|_next/static|_next/image|favicon.ico).*)',
       ],
}

export function middleware(request: NextRequest) {
       const path = request.nextUrl.pathname;
       const userRole = getUserRole(request);

       // Redirect authenticated users trying to access routeWithoutAuth paths
       if (userRole && routeWithoutAuth.includes(path)) {
              return NextResponse.redirect(new URL('/', request.url));
       }

       let allowedPaths = []; // * We will populate this array with the allowed paths based on the user role
       switch (userRole) {
              case 'Utilisateur':
                     allowedPaths = routeWithUserAuth;
                     break;
              case 'Moderateur':
                     allowedPaths = routeForModerator;
                     break;
              case 'Administrateur':
                     allowedPaths = routeForAdmin;
                     break;
              case 'SuperAdministrateur':
                     allowedPaths = routeForSuperAdmin;
                     break;
              default:
                     allowedPaths = [...routeWithoutAuth, ...routeForEveryone];
                     break;
       }

       const isPathAllowed = allowedPaths.some(allowedPath => {
              if (allowedPath instanceof RegExp) {
                     return allowedPath.test(path);
              }
              return allowedPath === path;
       });

       if (isPathAllowed) {
              return NextResponse.next();
       }

       if (!isPathAllowed) {
              // Aggregate all possible paths from all roles
              const allPaths = Array.from(new Set([
                     ...routeWithoutAuth,
                     ...routeForEveryone,
                     ...routeWithUserAuth,
                     ...routeForModerator,
                     ...routeForAdmin,
                     ...routeForSuperAdmin
                   ].flat()));
                   

              // Check against all possible paths to see if the route is really unrecognized
              const isKnownRoute = allPaths.some(knownPath => {
                     if (knownPath instanceof RegExp) {
                            return knownPath.test(path);
                     }
                     return knownPath === path;
              });

              // If it's not a known route, let Next.js handle it which could lead to a 404
              if (!isKnownRoute) {
                     return NextResponse.next();
              }

              // If it's a known route but not allowed, redirect to a safe place, like home or login
              return NextResponse.redirect(new URL('/connexion', request.url));
       }



       return NextResponse.redirect(new URL('/connexion', request.url));
};