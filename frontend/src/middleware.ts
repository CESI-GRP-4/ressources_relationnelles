import { NextRequest, NextResponse } from 'next/server'

const routeForEveryone = ['/'];

// Routes accessible without authentication
const routeWithoutAuth = [
       '/connexion',
       '/mot-de-passe-oublie',
       '/reinitialisation-mot-de-passe',
       '/verification-mail'
];

// Routes accessible to authenticated users (Utilisateur)
const routeWithUserAuth = [
       ...routeForEveryone,
];

// Routes accessible to Moderators (Moderateur)
const routeForModerator = [
       ...routeWithUserAuth,
       '/dashboard',
];

// Routes accessible to Admins (Administrateur)
const routeForAdmin = [
       ...routeForModerator,
       '/gestion-utilisateurs',
       '/gestion-utilisateurs-historique',
       '/statistiques/connexions',
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

       if (allowedPaths.some(allowedPath => allowedPath.includes(path))) {
              return NextResponse.next();
       }

       // Redirect users not allowed to access the path
       return NextResponse.redirect(new URL('/connexion', request.url));
};