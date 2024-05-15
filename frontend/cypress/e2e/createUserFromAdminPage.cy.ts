import { loginAsSuperAdmin, generateRandomEmail, generateRandomFirstName, generateRandomLastName } from "./utils";

describe('SuperAdmin user create', () => {
  it('Create user with correct data', () => {
    cy.intercept('POST', '/api/user/create').as('create');
    loginAsSuperAdmin();
    cy.visit('http://localhost:3000/gestion-utilisateurs');
    cy.get('.justify-start > :nth-child(2) > .ant-btn').should('be.visible').click();
    cy.get('#createUserForm_email').should('be.visible').clear().type(generateRandomEmail());
    cy.get('#createUserForm_firstName').should('be.visible').clear().type(generateRandomFirstName());
    cy.get('#createUserForm_lastName').should('be.visible').clear().type(generateRandomLastName());
    cy.get('#createUserForm_role').should('be.visible').type('Utilisateur');
    cy.get('.ant-select-item-option-active > .ant-select-item-option-content').click();
    cy.get('.ant-btn-dashed > span').should('be.visible').click();
    cy.wait(3000);
    cy.get('.ant-space > :nth-child(2) > .ant-btn').should('be.visible').click();
    cy.wait('@create').its('response.statusCode').should('eq', 201);

  })
})