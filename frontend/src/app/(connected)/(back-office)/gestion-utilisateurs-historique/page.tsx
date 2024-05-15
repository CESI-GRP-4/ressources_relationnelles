"use client"
import UserManagementHistory from "@/components/back-office/user-management-history/usersManagementHistory";
import PageSummary from "@/components/pageSummary";

export default function GestionUtilisateursHistorique() {
       return (
              <div className="flex flex-col gap-5">
                     <PageSummary
                            title="Historique des modifications"
                            description={`Bienvenue sur la page "Historique" des utilisateurs du tableau de bord d'administration de notre plateforme. Cette section vous offre une vue complète de toutes les modifications effectuées sur les comptes des utilisateurs. Ici, vous pouvez suivre les changements apportés aux profils, les activations ou désactivations de comptes, les modifications de rôles, et toutes autres actions administratives. Utilisez cette page pour maintenir une traçabilité des interventions et pour comprendre les évolutions dans la gestion des utilisateurs. Cette fonctionnalité est essentielle pour assurer la transparence et la gestion efficace de la communauté.`}/>
                     <UserManagementHistory />
              </div>
       );
}