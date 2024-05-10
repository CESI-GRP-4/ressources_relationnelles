import { waitAndClick, loginAsSuperAdmin } from './utils';

describe('Change user data test', () => {

  it('Change user firstName', () => {
    loginAsSuperAdmin();
    cy.visit('http://localhost:3000/profil');
    cy.get('li > :nth-child(1) > .ant-btn').click();
    cy.get('#lastName').clear().type('Test');
    cy.get('[style="display: flex; justify-content: center; padding-top: 1%;"] > .ant-btn').click();
  });

  it('Change user with bad email', () => {
    loginAsSuperAdmin();
    cy.visit('http://localhost:3000/profil');
    cy.get('li > :nth-child(1) > .ant-btn').click();
    cy.get('#email').clear().type('Test');
    cy.get('[style="display: flex; justify-content: center; padding-top: 1%;"] > .ant-btn').click();
  });

})