// userAttributesToFrench.ts
interface FrenchUserAttributeLabels {
       [key: string]: string;
}

export const getUserAttributeLabelsInFrench = (): FrenchUserAttributeLabels => {
       return {
              firstName: "Prénom",
              lastName: "Nom de famille",
              email: "E-mail",
              imgURL: "URL de l'image",
              id: "Identifiant",
              role: "Rôle",
              isEmailVerified: "E-mail vérifié",
              city: "Ville",
              country: "Pays",
              countryCode: "Code du pays",
              postalCode: "Code postal",
              createdAt: "Créé le",
              updatedAt: "Mis à jour le",
              isBanned: "Est banni",
              newUser: "Nouvel utilisateur",
       };
};
