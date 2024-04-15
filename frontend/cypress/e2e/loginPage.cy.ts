describe('Login page', () => {
       it('Login with empty email and password', () => {
              cy.visit('http://localhost:3000/connexion');
              cy.contains('button', 'Se connecter').click();

              // Check if error messages are displayed
              cy.get('#logInForm_email_help > .ant-form-item-explain-error').and('contain', 'Veuillez entrer votre adresse e-mail');
              cy.get('#logInForm_password_help > .ant-form-item-explain-error').should('be.visible').and('contain', 'Veuillez entrer votre mot de passe');
       });

       it('Login with right credentials', () => {
              cy.visit('http://localhost:3000/connexion');
              cy.get('#logInForm_email').type('john.doe@example.com');
              cy.get('#logInForm_password').type('aze');
              cy.contains('button', 'Se connecter').click();
              cy.url().should('eq', 'http://localhost:3000/');
       });

       it('Login with wrong credentials', () => {
              cy.visit('http://localhost:3000/connexion');
              cy.get('#logInForm_email').type('ee');
              cy.get('#logInForm_password').type('ee');
              cy.contains('button', 'Se connecter').click();
              cy.url().should('eq', 'http://localhost:3000/connexion');

              // input fields should be empty
              cy.get('#logInForm_email').should('have.value', '');
              cy.get('#logInForm_password').should('have.value', '');
       });
});
