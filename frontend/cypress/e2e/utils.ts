export const waitAndClick = (selector: string) => {
       cy.get(selector).should('be.visible').click();
};

export const loginAsSuperAdmin = () => {
       cy.intercept('POST', '/api/login').as('loginRequest');

       // Visit the login page
       cy.visit('http://localhost:3000/connexion');

       // Enter the login credentials
       cy.get('#logInForm_email').should('be.visible').type('john.doe@example.com');
       cy.get('#logInForm_password').should('be.visible').type('aze');

       // Submit the form
       cy.get(':nth-child(4) > .ant-row > .ant-col > .ant-form-item-control-input > .ant-form-item-control-input-content > .ant-btn').should('be.visible').click();

       // Wait for the login request to complete
       cy.wait('@loginRequest').its('response.statusCode').should('eq', 200);
}