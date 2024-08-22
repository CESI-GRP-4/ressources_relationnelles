import { waitAndClick, loginAsSuperAdmin } from './utils';

describe('Change user data test', () => {

  it('Change user firstName', () => {
    cy.intercept('POST', '/api/profil/update').as('update');
    loginAsSuperAdmin();
    cy.visit('http://91.108.112.237:3001/profil');
    cy.get('li > :nth-child(1) > .ant-btn').click();
    cy.get('#profilForm_lastName').clear().type('Test');
    cy.get('[style="display: flex; justify-content: center; padding-top: 1%;"] > .ant-btn').click();
    cy.wait('@update').its('response.statusCode').should('eq', 200);

  });

  it('Change user with bad email', () => {
    loginAsSuperAdmin();
    cy.visit('http://91.108.112.237:3001/profil');
    cy.get('li > :nth-child(1) > .ant-btn').click();
    cy.get('#profilForm_email').clear().type("hello, word !");
    cy.get('[style="display: flex; justify-content: center; padding-top: 1%;"] > .ant-btn').click();
    cy.get('#profilForm_email_help > .ant-form-item-explain-error').should('be.visible').and('contain', 'Entrez une adresse mail valide');
  });

})