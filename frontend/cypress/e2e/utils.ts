export const waitAndClick = (selector: string) => {
       cy.get(selector).should('be.visible').click();
};

export const loginAsSuperAdmin = () => {
       cy.intercept('POST', '/api/login').as('loginRequest');

       // Visit the login page
       cy.visit('http://91.108.112.237:3001/connexion');

       // Enter the login credentials
       cy.get('#logInForm_email').should('be.visible').type('c.arthur@gmail.com');
       cy.get('#logInForm_password').should('be.visible').type('aze');

       // Submit the form
       cy.get(':nth-child(4) > .ant-row > .ant-col > .ant-form-item-control-input > .ant-form-item-control-input-content > .ant-btn').should('be.visible').click();

       // Wait for the login request to complete
       cy.wait('@loginRequest').its('response.statusCode').should('eq', 200);
}


export function generateRandomEmail() {
       const randomString = Math.random().toString(36).substring(2, 10);
       return `test.${randomString}@example.com`;
}

export function generateRandomFirstName() {
       const firstNames = ['John', 'Jane', 'Alex', 'Emily', 'Chris', 'Katie', 'Michael', 'Sarah', 'David', 'Laura'];
       return firstNames[Math.floor(Math.random() * firstNames.length)];
}

export function generateRandomLastName() {
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