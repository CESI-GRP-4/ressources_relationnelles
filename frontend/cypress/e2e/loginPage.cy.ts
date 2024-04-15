describe('Login page', () => {
       it('Login with empty email and password', () => {
              cy.visit('http://localhost:3000/connexion');
              cy.contains('button', 'Se connecter').click();

              // Check if error messages are displayed
              cy.get('#logInForm_email_help > .ant-form-item-explain-error').and('contain', 'Veuillez entrer votre adresse e-mail');
              cy.get('#logInForm_password_help > .ant-form-item-explain-error').should('be.visible').and('contain', 'Veuillez entrer votre mot de passe');
       });
});
