import { loginAsSuperAdmin, generateRandomEmail, generateRandomFirstName, generateRandomLastName } from "./utils";


describe('Dashboard page', () => {
  it('Check if the dashboard is accessible after login', () => {
    loginAsSuperAdmin();
    cy.visit('http://localhost:3000/tableau-de-bord');

    // Ensure you are on the tableau-de-bord URL
    cy.url().should('eq', 'http://localhost:3000/tableau-de-bord');
    cy.intercept('POST', '/api/gestion-utilisateurs/create').as('createRequest');

    const randomEmail = generateRandomEmail();
    const randomFirstName = generateRandomFirstName();
    const randomLastName = generateRandomLastName();

    cy.get('.mr-20 > .ant-btn').click();
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