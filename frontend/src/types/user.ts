export default interface User {
       firstName?: string;
       lastName?: string;
       email?: string;
       imgURL?: string;
       id?: string;
       role?: 'user' | 'moderator' | 'administrator' | 'superadministrator';
       isEmailVerified?: boolean;
       city?: string;
       country?: string;
       postalCode?: string;
       newUser: boolean;
}
