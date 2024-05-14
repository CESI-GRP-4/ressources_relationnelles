import { loginAsSuperAdmin } from "./utils";

describe('Logout', () => {
       it('Login then logout, should work.', () => {
              loginAsSuperAdmin();
              cy.intercept('POST', '/api/logout').as('logout');
              cy.visit('http://localhost:3000/profil');

              cy.get('.ant-menu-title-content > .ant-avatar > img').should('be.visible').click();
              cy.get('.ant-menu-item-danger').should('be.visible').click();
              cy.wait('@logout').its('response.statusCode').should('eq', 200);
       });
});
