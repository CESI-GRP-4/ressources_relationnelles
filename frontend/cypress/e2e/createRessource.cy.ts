import { waitAndClick, loginAsSuperAdmin } from './utils';

describe('Ressource creation', () => {
       it("Create ressource with correct data", () => {
              loginAsSuperAdmin();
              cy.visit('http://localhost:3000/creer-ressource');
              cy.url().should('eq', 'http://localhost:3000/creer-ressource');
              cy.intercept('POST', '/api/ressource/create').as('createRequest');

              const randomTitle = generateRandomText(10);
              const randomDescription = generateRandomText(150)

              cy.wait(500)
              cy.get('#createRessourceForm').should('not.be.disabled');
              cy.get('#createRessourceForm_label').should('be.visible').and("be.enabled").and("not.be.disabled").type(randomTitle);
              cy.get('#createRessourceForm_description').should('be.visible').and("be.enabled").and("not.be.disabled").type(randomDescription);

              // Handling search and select:
              cy.get('#rc_select_0').type('voyages{enter}');

              cy.get('.ant-form-item-control-input-content > .ant-btn').click();
              cy.wait('@createRequest').should(({ response }) => {
                     if(response) expect(response.statusCode).to.eq(201);
              });
       });
});

function generateRandomText(length: number): string {
       const characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
       let result = '';
       const charactersLength = characters.length;
       for (let i = 0; i < length; i++) {
              result += characters.charAt(Math.floor(Math.random() * charactersLength));
       }
       return result;
}