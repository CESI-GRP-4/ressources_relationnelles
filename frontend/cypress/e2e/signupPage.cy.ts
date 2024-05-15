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

       it('Signup with right information', () => {
              cy.intercept('POST', '/api/signup').as('signup');

              const randomEmail = generateRandomEmail();
              const randomFirstName = generateRandomFirstName();
              const randomLastName = generateRandomLastName();
              const randomPassword = generateRandomPassword();
              cy.visit('http://localhost:3000/connexion');
              cy.get('[style="opacity:1;order:1"] > .ant-menu-title-content > .ant-typography').should('be.visible').click();
              cy.get('#signUpForm_email').should('be.visible').should('not.be.disabled').type(randomEmail);
              cy.get('#signUpForm_firstName').should('be.visible').should('not.be.disabled').type(randomFirstName);
              cy.get('#signUpForm_lastName').should('be.visible').should('not.be.disabled').type(randomLastName);
              cy.get('#signUpForm_password').should('be.visible').should('not.be.disabled').type(randomPassword);
              cy.get(':nth-child(5) > .ant-row > .ant-col > .ant-form-item-control-input > .ant-form-item-control-input-content > .ant-btn').should('be.visible').should('not.be.disabled').click()
              cy.wait('@signup').its('response.statusCode').should('eq', 200);
       });

       it('Signup with existing email', () => {
              cy.intercept('POST', '/api/signup').as('signup');

              const randomEmail = generateRandomEmail();
              const randomFirstName = generateRandomFirstName();
              const randomLastName = generateRandomLastName();
              const randomPassword = generateRandomPassword();
              cy.visit('http://localhost:3000/connexion');
              cy.get('[style="opacity:1;order:1"] > .ant-menu-title-content > .ant-typography').should('be.visible').click();
              cy.get('#signUpForm_email').should('be.visible').should('not.be.disabled').type("john.doe@example.com");
              cy.get('#signUpForm_firstName').should('be.visible').should('not.be.disabled').type(randomFirstName);
              cy.get('#signUpForm_lastName').should('be.visible').should('not.be.disabled').type(randomLastName);
              cy.get('#signUpForm_password').should('be.visible').should('not.be.disabled').type(randomPassword);
              cy.get(':nth-child(5) > .ant-row > .ant-col > .ant-form-item-control-input > .ant-form-item-control-input-content > .ant-btn').should('be.visible').should('not.be.disabled').click()
              cy.wait('@signup').its('response.statusCode').should('eq', 401);
       });

       it('Signup with deleted account', () => {
              cy.intercept('POST', '/api/signup').as('signup');

              const randomEmail = generateRandomEmail();
              const randomFirstName = generateRandomFirstName();
              const randomLastName = generateRandomLastName();
              const randomPassword = generateRandomPassword();
              cy.visit('http://localhost:3000/connexion');
              cy.get('[style="opacity:1;order:1"] > .ant-menu-title-content > .ant-typography').should('be.visible').click();
              cy.get('#signUpForm_email').should('be.visible').should('not.be.disabled').type("John.sup@example.com");
              cy.get('#signUpForm_firstName').should('be.visible').should('not.be.disabled').type(randomFirstName);
              cy.get('#signUpForm_lastName').should('be.visible').should('not.be.disabled').type(randomLastName);
              cy.get('#signUpForm_password').should('be.visible').should('not.be.disabled').type(randomPassword);
              cy.get(':nth-child(5) > .ant-row > .ant-col > .ant-form-item-control-input > .ant-form-item-control-input-content > .ant-btn').should('be.visible').should('not.be.disabled').click()
              cy.wait('@signup').its('response.statusCode').should('eq', 403);
       });
});


function generateRandomEmail() {
       const randomString = Math.random().toString(36).substring(2, 10);
       return `test.${randomString}@example.com`;
}

function generateRandomFirstName() {
       const firstNames = ['John', 'Jane', 'Alex', 'Emily', 'Chris', 'Katie', 'Michael', 'Sarah', 'David', 'Laura'];
       return firstNames[Math.floor(Math.random() * firstNames.length)];
}

function generateRandomLastName() {
       const lastNames = ['Smith', 'Johnson', 'Williams', 'Jones', 'Brown', 'Davis', 'Miller', 'Wilson', 'Moore', 'Taylor'];
       return lastNames[Math.floor(Math.random() * lastNames.length)];
}

export function generateRandomPassword() {
       const lowerCaseChars = 'abcdefghijklmnopqrstuvwxyz';
       const upperCaseChars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
       const digits = '0123456789';
       const specialChars = '@$!%*?&';

       function getRandomChar(chars: string) {
              return chars.charAt(Math.floor(Math.random() * chars.length));
       }

       let password = '';
       password += getRandomChar(lowerCaseChars);
       password += getRandomChar(upperCaseChars);
       password += getRandomChar(digits);
       password += getRandomChar(specialChars);

       const allChars = lowerCaseChars + upperCaseChars + digits + specialChars;
       for (let i = 4; i < 8; i++) { // Ensuring minimum length of 8 characters
              password += getRandomChar(allChars);
       }

       password = password.split('').sort(() => 0.5 - Math.random()).join(''); // Shuffle the password characters

       // If needed, continue adding random characters to meet length requirement beyond 8
       while (password.length < 12) {
              password += getRandomChar(allChars);
       }

       return password;
}