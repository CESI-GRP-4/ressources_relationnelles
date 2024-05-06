import { loginAsSuperAdmin } from "./utils";

describe('Dashboard page', () => {
       it('Check if the dashboard is accessible after login', () => {
              loginAsSuperAdmin();
              cy.visit('http://localhost:3000/dashboard');

              // Ensure you are on the dashboard URL
              cy.url().should('eq', 'http://localhost:3000/dashboard');
       });

       it('Check if the dashboard contains the expected elements (for a super admin)', () => {
              loginAsSuperAdmin();
              cy.visit('http://localhost:3000/dashboard');
              cy.url().should('eq', 'http://localhost:3000/dashboard');
              
              cy.get(':nth-child(1) > .ant-card > .ant-card-head > .ant-card-head-wrapper > .ant-card-head-title').should('contain', 'Informations du gestionnaire');
              cy.get('.flex-wrap > :nth-child(2) > .ant-card > .ant-card-head > .ant-card-head-wrapper > .ant-card-head-title').should('contain', 'Actions récentes sur les utilisateurs');
              cy.get(':nth-child(3) > .ant-card > .ant-card-head > .ant-card-head-wrapper > .ant-card-head-title').should('contain', 'Utilisateurs');
              cy.get(':nth-child(4) > .ant-card > .ant-card-head > .ant-card-head-wrapper > .ant-card-head-title').should('contain', 'Catégories');
              cy.get('.w-1\\/2 > .ant-card-head > .ant-card-head-wrapper > .ant-card-head-title').should('contain', 'Statistiques de connexions (semaine actuelle)');
              cy.get(':nth-child(6) > .ant-card > .ant-card-head > .ant-card-head-wrapper > .ant-card-head-title').should('contain', 'Ressources');
       });
});
