import { loginAsSuperAdmin } from "./utils";

describe('Login page', () => {
       it('Login with empty email and password', () => {

              cy.visit('http://localhost:3000/connexion');
              cy.get(':nth-child(4) > .ant-row > .ant-col > .ant-form-item-control-input > .ant-form-item-control-input-content > .ant-btn').should('be.visible').click();

              // Check if error messages are displayed
              cy.get('#logInForm_email_help > .ant-form-item-explain-error').and('contain', 'Veuillez entrer votre adresse e-mail');
              cy.get('#logInForm_password_help > .ant-form-item-explain-error').should('be.visible').and('contain', 'Veuillez entrer votre mot de passe');
       });

       it('Login with right credentials', () => {
              loginAsSuperAdmin();
       });

       it('Login with wrong credentials', () => {
              cy.visit('http://localhost:3000/connexion');
              cy.get('#logInForm_email').type('ee');
              cy.get('#logInForm_password').type('ee');
              cy.get(':nth-child(4) > .ant-row > .ant-col > .ant-form-item-control-input > .ant-form-item-control-input-content > .ant-btn').should('be.visible').click();
              cy.url().should('eq', 'http://localhost:3000/connexion');

              // input fields should be empty
              cy.get('#logInForm_email').should('have.value', '');
              cy.get('#logInForm_password').should('have.value', '');
       });

       // toggle password visibility
       it('Toggle password visibility', () => {
              cy.visit('http://localhost:3000/connexion');
              cy.get('#logInForm_password').type('aze');
              cy.get('.ant-form-item-has-success > .ant-row > .ant-form-item-control > .ant-form-item-control-input > .ant-form-item-control-input-content > .ant-input-affix-wrapper > .ant-input-suffix').click();
              cy.get('#logInForm_password').should('have.attr', 'type', 'text');
              cy.get('.ant-form-item-has-success > .ant-row > .ant-form-item-control > .ant-form-item-control-input > .ant-form-item-control-input-content > .ant-input-affix-wrapper > .ant-input-suffix').click();
              cy.get('#logInForm_password').should('have.attr', 'type', 'password');
       });
});
