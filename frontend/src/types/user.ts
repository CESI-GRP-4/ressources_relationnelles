export default interface User {
       id?: string;
       firstName?: string;
       lastName?: string;
       email?: string;
       imgURL?: string;
       role?: 'Utilisateur' | 'Moderateur' | 'Administrateur' | 'SuperAdministrateur';
       isEmailVerified?: boolean;
       city?: string;
       country?: string;
       countryCode?: string;
       postalCode?: string;
       createdAt?: string | number | Date;
       updatedAt?: string | number | Date;
       isBanned?: boolean;
       newUser?: boolean;
}
