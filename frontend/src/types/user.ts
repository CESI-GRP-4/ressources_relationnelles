export default interface User {
       firstName?: string;
       lastName?: string;
       email?: string;
       imgURL?: string;
       id?: string;
       role?: 'Utilisateur' | 'Moderateur' | 'Administrateur' | 'SuperAdministrateur';
       isEmailVerified?: boolean;
       city?: string;
       country?: string;
       countryCode?: string;
       postalCode?: string;
       createdAt?: string | number | Date;
       updatedAt?: string | number | Date;
       isBlocked?: boolean;
}
