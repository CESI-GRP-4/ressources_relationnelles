import { loginAsSuperAdmin } from "./utils";

describe('Login page', () => {
       it('Login with empty email and password', () => {
              cy.visit('http://localhost:3000/connexion');
              cy.get(':nth-child(4) > .ant-row > .ant-col > .ant-form-item-control-input > .ant-form-item-control-input-content > .ant-btn').should('be.visible').click();

              // Check if error messages are displayed
              cy.get('#logInForm_email_help > .ant-form-item-explain-error').and('contain', 'Veuillez entrer votre adresse e-mail');
              cy.get('#logInForm_password_help > .ant-form-item-explain-error').should('be.visible').and('contain', 'Veuillez entrer votre mot de passe');
              cy.url().should('eq', 'http://localhost:3000/connexion');
       });

       it('Login with right credentials', () => {
              loginAsSuperAdmin();
       });

       it('Login with wrong credentials', () => {
              cy.visit('http://localhost:3000/connexion');
              cy.intercept('POST', '/api/login').as('loginRequest');

              cy.get('#logInForm_email').type('aa.bb@cc.dd');
              cy.get('#logInForm_password').type('ee');
              cy.get(':nth-child(4) > .ant-row > .ant-col > .ant-form-item-control-input > .ant-form-item-control-input-content > .ant-btn').should('be.visible').click();
              cy.url().should('eq', 'http://localhost:3000/connexion');

              // input fields should be empty
              cy.get('#logInForm_email').should('have.value', '');
              cy.get('#logInForm_password').should('have.value', '');

              cy.wait('@loginRequest').should(({ response }) => {
                     if (response) expect(response.statusCode).to.eq(401);
              });
       });

       it('Login with banned account', () => {
              cy.intercept('POST', '/api/login').as('loginRequest');

              // Visit the login page
              cy.visit('http://localhost:3000/connexion');

              // Enter the login credentials
              cy.get('#logInForm_email').should('be.visible').type('john.ban@example.com');
              cy.get('#logInForm_password').should('be.visible').type('aze');

              // Submit the form
              cy.get(':nth-child(4) > .ant-row > .ant-col > .ant-form-item-control-input > .ant-form-item-control-input-content > .ant-btn').should('be.visible').click();

              cy.url().should('eq', 'http://localhost:3000/connexion');

              // Wait for the login request to complete
              cy.wait('@loginRequest').its('response.statusCode').should('eq', 403);
              cy.get('.ant-message-custom-content > :nth-child(2)').should('be.visible').should('contain', 'Votre compte est banni');
       });

       it('Login with deleted account', () => {
              cy.intercept('POST', '/api/login').as('loginRequest');

              // Visit the login page
              cy.visit('http://localhost:3000/connexion');

              // Enter the login credentials
              cy.get('#logInForm_email').should('be.visible').type('john.sup@example.com');
              cy.get('#logInForm_password').should('be.visible').type('aze');

              // Submit the form
              cy.get(':nth-child(4) > .ant-row > .ant-col > .ant-form-item-control-input > .ant-form-item-control-input-content > .ant-btn').should('be.visible').click();
              cy.url().should('eq', 'http://localhost:3000/connexion');

              // Wait for the login request to complete
              cy.wait('@loginRequest').its('response.statusCode').should('eq', 403);
              cy.get('.ant-message-custom-content > :nth-child(2)').should('be.visible').should('contain', 'Votre compte a été supprimé');

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
