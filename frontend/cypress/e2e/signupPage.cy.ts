describe('Signup page', () => {
       it('Signup with empty email and password', () => {
              cy.visit('http://localhost:3000/connexion');
              cy.get('[style="opacity:1;order:1"] > .ant-menu-title-content > .ant-typography').click();
              cy.get(':nth-child(5) > .ant-row > .ant-col > .ant-form-item-control-input > .ant-form-item-control-input-content > .ant-btn > span').should('be.visible').click();

              // Check if error messages are displayed
              cy.get('#signUpForm_email_help > .ant-form-item-explain-error').should('be.visible').and('contain', 'Veuillez entrer votre adresse e-mail');
              cy.get('#signUpForm_firstName_help > .ant-form-item-explain-error').should('be.visible').and('contain', 'Veuillez entrer votre prénom');
              cy.get('#signUpForm_lastName_help > .ant-form-item-explain-error').should('be.visible').and('contain', 'Veuillez entrer votre nom de famille');
              cy.get('#signUpForm_password_help > .ant-form-item-explain-error').should('be.visible').and('contain', 'Veuillez entrer votre mot de passe');
       });

       // it('Signup with right credentials', () => {
       //        cy.visit('http://localhost:3000/inscription');
       //        cy.get('#signUpForm_email').type('
});