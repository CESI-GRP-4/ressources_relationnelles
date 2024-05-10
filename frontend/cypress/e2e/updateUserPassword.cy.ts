import { waitAndClick, loginAsSuperAdmin } from './utils';

describe('Change password test', () => {

  it('Change password with correct data', () => {
    loginAsSuperAdmin();
    cy.visit('http://localhost:3000/profil');
    cy.get('li > :nth-child(1) > .ant-btn').click();
    cy.get('#oldPassword').should('be.visible').type('aze');
    cy.get('#password').should('be.visible').type('Testtest1@');
    cy.get('#confirmPassword').should('be.visible').type('Testtest1@');
    cy.get('.ant-form-item-control-input-content > .ant-btn').should('be.visible').click();
  });

  it('Change password with bad oldpassword', () => {
    loginAsSuperAdmin();
    cy.visit('http://localhost:3000/profil');
    cy.get('li > :nth-child(1) > .ant-btn').click();
    cy.get('#oldPassword').should('be.visible').type('test');
    cy.get('#password').should('be.visible').type('Testtest1@');
    cy.get('#confirmPassword').should('be.visible').type('Testtest1@');
    cy.get('.ant-form-item-control-input-content > .ant-btn').should('be.visible').click();
  });

})