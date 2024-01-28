import { NextResponse } from 'next/server'
import type { NextRequest } from 'next/server'

const routeForEveryone = ['/presentation']; // '/presentation' étant la page de présentation du site
const routeWithoutAuth = ['/login', '/register', '/resetPassword'];
const routeWithUserAuth = ['/getProfil', '/contact/page', '/createRessource', '/getCategories', '/getCategory', '/getRessouce', '/getMyRessources', '/getRessouces', '/getBooksmark', '/getHistory', '/categorie', '/ressource', '/query']
const routeForModerator = ['/getListComments', '/acceptComment/:id', '/rejectComment/:id', '/getListRessources', '/acceptRessource/:id', '/rejectRessource/:id', '/getListFiles', '/acceptFile/:id', 'rejectFile/:id']
const routeForAdmin = ['/getUsers', '/deleteUser', '/blockUser', '/getListCategories', '/addCategory', '/removeCategory', '/editCategory']
const routeForSuperAdmin = ['/passUserModo', 'passUserAdmin']

// This function can be marked `async` if using `await` inside
export function middleware(request: NextRequest) {
       const pathname = request.nextUrl.pathname;
       let userRole = 'admin';

       if (routeForEveryone.includes(pathname) || routeWithoutAuth.includes(pathname)) {
              console.log('Page accessible à tous');

       } else if (routeWithUserAuth.includes(pathname) && userRole == 'user') {
              console.log('Page accessible aux utilisateurs connectés');

       } else if (routeForModerator.includes(pathname) && userRole == 'modo') {
              console.log('Page accessible aux modérateurs');

       } else if (routeForAdmin.includes(pathname) && userRole == 'admin') {
              console.log('Page accessible aux administrateurs');

       } else if (routeForSuperAdmin.includes(pathname) && userRole == 'superAdmin') {
              console.log('Page accessible aux super administrateurs');

       } else {
              console.error('Erreur : Accès non autorisé');
       }


       // return NextResponse.redirect(new URL('/home', request.url))
}

export const config = {
       matcher: [routeForEveryone, routeWithoutAuth, routeWithUserAuth, routeForModerator, routeForAdmin, routeForSuperAdmin],
}
/* Pages à rediscuter

/editProfil 

*/