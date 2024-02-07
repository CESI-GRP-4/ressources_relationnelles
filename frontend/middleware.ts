import UserProvider from '@/providers/userProvider';
import { NextResponse } from 'next/server'
import type { NextRequest } from 'next/server'
import { useUser } from "@/providers/userProvider";

const routeForEveryone = ['/presentation']; // '/presentation' étant la page de présentation du site
const routeWithoutAuth = ['/login', '/register', '/resetPassword'];
const routeWithUserAuth = ['/profil', '/contact', '/about', '/createRessource', '/myRessources', '/ressource', '/myBooksmark', '/ressourceHistory', '/search', '/categories']
const routeForModerator = ['/manageComments', '/newRessources', '/newFiles']
const routeForAdmin = ['/usersList', '/manageCategories', '/stats']
const routeForSuperAdmin = ['/usersList']
const { user, setUser }  = useUser();

// This function can be marked `async` if using `await` inside
export async function middleware(request: NextRequest) {
       const pathname = request.nextUrl.pathname;

       let responseFromAPI = await fetch('http://localhost:3000/api/verifyUser');

       try {
              if (!responseFromAPI.ok) {
                     return NextResponse.redirect(new URL('/home', request.url))
              } else {
                     let data = await responseFromAPI.json();
                   
                     let userRole = data.role;
       
                     if (routeForEveryone.includes(pathname)) {
                            console.log('Page accessible à tous');
                            return NextResponse.next()
       
                     }
                     if (routeWithUserAuth.includes(pathname) && userRole == 'user') {
                            console.log('Page accessible aux utilisateurs connectés');
                            return NextResponse.next()
       
                     }
                     if (routeForModerator.includes(pathname) && userRole == 'moderator') {
                            console.log('Page accessible aux modérateurs');
                            return NextResponse.next()
       
                     }
                     if (routeForAdmin.includes(pathname) && userRole == 'administrator') {
                            console.log('Page accessible aux administrateurs');
                            return NextResponse.next()
       
                     }
                     if (routeForSuperAdmin.includes(pathname) && userRole == 'superadministrator') {
                            console.log('Page accessible aux super administrateurs');
                            return NextResponse.next()
       
                     }
              }
       } catch (error) {
              console.error('Erreur : Accès non autorisé');
              console.error(error);
              return NextResponse.redirect(new URL('/home', request.url))
       }
}

export const config = {
       matcher: [routeForEveryone, routeWithoutAuth, routeWithUserAuth, routeForModerator, routeForAdmin, routeForSuperAdmin],
}
