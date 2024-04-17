describe('Dashboard page', () => {
       it('Check if the dashboard is accessible after login', () => {
              // Intercept the login POST request
              cy.intercept('POST', '/api/login').as('loginRequest');

              // Visit the login page
              cy.visit('http://localhost:3000/connexion');

              // Enter the login credentials
              cy.get('#logInForm_email').type('john.doe@example.com');
              cy.get('#logInForm_password').type('aze');

              // Submit the form
              cy.contains('button', 'Se connecter').click();

              // Wait for the login request to complete
              cy.wait('@loginRequest').its('response.statusCode').should('eq', 200);

              // Verify that you have been redirected to the home page
              cy.url().should('eq', 'http://localhost:3000/');

              // Optionally, depending on your application's behavior, you might wait for some indication
              // that the page has fully loaded and that the user session has been established, such as
              // a user-specific element like a username display or a logout link.

              // a span element that contains the text "home page"
              cy.get('span').should('contain', 'home page', { timeout: 10000 }).should('be.visible');

              // Now navigate to the dashboard
              cy.visit('http://localhost:3000/dashboard');

              // Ensure you are on the dashboard URL
              cy.url().should('eq', 'http://localhost:3000/dashboard');
       });

       it('Check if the dashboard contains the expected elements (for a super admin)', () => {
              cy.intercept('POST', '/api/login').as('loginRequest');
              cy.visit('http://localhost:3000/connexion');
              cy.get('#logInForm_email').type('john.doe@example.com');
              cy.get('#logInForm_password').type('aze');
              cy.contains('button', 'Se connecter').click();
              cy.wait('@loginRequest').its('response.statusCode').should('eq', 200);
              cy.url().should('eq', 'http://localhost:3000/');
              cy.get('span').should('contain', 'home page', { timeout: 10000 }).should('be.visible');
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
