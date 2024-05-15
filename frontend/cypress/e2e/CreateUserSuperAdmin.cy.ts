import { loginAsSuperAdmin, generateRandomEmail, generateRandomFirstName, generateRandomLastName } from "./utils";


describe('User management', () => {
  it('Create a user from the user management page from back-office', () => {
    loginAsSuperAdmin();
    cy.visit('http://localhost:3000/gestion-utilisateurs');

    // Ensure you are on the tableau-de-bord URL
    cy.url().should('eq', 'http://localhost:3000/gestion-utilisateurs');
    cy.intercept('POST', '/api/user/create').as('createRequest');

    const randomEmail = generateRandomEmail();
    const randomFirstName = generateRandomFirstName();
    const randomLastName = generateRandomLastName();

    cy.get('.justify-start > :nth-child(2) > .ant-btn').click();
    cy.get('#createUserForm_email').clear().type(randomEmail);;
    cy.get('#createUserForm_firstName').clear().type(randomFirstName);
    cy.get('#createUserForm_lastName').clear().type(randomLastName);
    cy.get('#createUserForm_role').click();
    cy.get('[title="Super-administrateur"] > .ant-select-item-option-content').click();
    cy.get('.ant-space > :nth-child(2) > .ant-btn').click();
    cy.wait('@createRequest').its('response.statusCode').should('eq', 201);

  });
})