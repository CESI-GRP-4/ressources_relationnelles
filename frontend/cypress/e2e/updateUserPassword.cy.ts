describe('Change password test', () => {
       it('Change password with bad oldpassword', () => {
              cy.intercept('POST', '/api/login').as('loginRequest');
              cy.visit('http://localhost:3000/connexion');
              cy.get('#logInForm_email').should('be.visible').type('john.doe@example.com');
              cy.get('#logInForm_password').should('be.visible').type('testtesttestT123@');
              cy.get(':nth-child(4) > .ant-row > .ant-col > .ant-form-item-control-input > .ant-form-item-control-input-content > .ant-btn').should('be.visible').click();
              cy.wait('@loginRequest').its('response.statusCode').should('eq', 200);

              cy.intercept('POST', '/api/profil/updatePassword').as('updatePassword');
              cy.visit('http://localhost:3000/profil');
              cy.get('li > :nth-child(1) > .ant-btn').click();
              cy.get(':nth-child(1) > .ant-col-24 > .ant-form-item > .ant-row > .ant-form-item-control > .ant-form-item-control-input > .ant-form-item-control-input-content > .ant-input-affix-wrapper').should('be.visible').type('test');
              cy.get('#password').should('be.visible').type('Testtest1@');
              cy.get('#confirmPassword').should('be.visible').type('Testtest1@');
              cy.get('.ant-form-item-control-input-content > .ant-btn').should('be.visible').click();
              cy.wait('@updatePassword').its('response.statusCode').should('eq', 400);
       });

       it('Change password with correct data', () => {
              // login
              cy.intercept('POST', '/api/login').as('loginRequest');
              cy.visit('http://localhost:3000/connexion');
              cy.get('#logInForm_email').should('be.visible').type('john.doe@example.com');
              cy.get('#logInForm_password').should('be.visible').type('testtesttestT123@');
              cy.get(':nth-child(4) > .ant-row > .ant-col > .ant-form-item-control-input > .ant-form-item-control-input-content > .ant-btn').should('be.visible').click();
              cy.wait('@loginRequest').its('response.statusCode').should('eq', 200);

              cy.intercept('POST', '/api/profil/updatePassword').as('updatePassword');

              cy.visit('http://localhost:3000/profil');
              cy.get('li > :nth-child(1) > .ant-btn').should('not.be.disabled').click();
              cy.get('#oldPassword').should('be.visible').type('testtesttestT123@');
              cy.get('#password').should('be.visible').type('RandomPassword123@@');
              cy.get('#confirmPassword').should('be.visible').type('RandomPassword123@@');
              cy.get('.ant-form-item-control-input-content > .ant-btn').should('be.visible').click();
              cy.wait('@updatePassword').its('response.statusCode').should('eq', 200);

              cy.get('.ant-menu-submenu-selected').should('be.visible').click();
              cy.get('.ant-menu-item-danger').should('be.visible').click();

              /* Partie Login */
              cy.intercept('POST', '/api/login').as('loginRequest');
              cy.wait(4000);
              cy.visit('http://localhost:3000/connexion');
              cy.get('#logInForm_email').should('be.visible').type('john.doe@example.com');
              cy.get('#logInForm_password').should('be.visible').type('RandomPassword123@@');
              cy.get(':nth-child(4) > .ant-row > .ant-col > .ant-form-item-control-input > .ant-form-item-control-input-content > .ant-btn').should('be.visible').click();
              cy.wait('@loginRequest').its('response.statusCode').should('eq', 200);

              cy.visit('http://localhost:3000/profil');
              cy.intercept('POST', '/api/profil/updatePassword').as('updatePassword2');
              cy.get('li > :nth-child(1) > .ant-btn').should('not.be.disabled').click();
              cy.get('#oldPassword').should('be.visible').type('RandomPassword123@@');
              cy.get('#password').should('be.visible').type('testtesttestT123@');
              cy.get('#confirmPassword').should('be.visible').type('testtesttestT123@');
              cy.get('.ant-form-item-control-input-content > .ant-btn').should('be.visible').click();
              cy.wait('@updatePassword2').its('response.statusCode').should('eq', 200);
       });

})