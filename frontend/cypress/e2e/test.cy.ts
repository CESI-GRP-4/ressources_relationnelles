import { generateRandomPassword, generateRandomEmail, generateRandomFirstName, generateRandomLastName } from "./utils";

describe('Home page pipeline', () => {
       it('zzzz', () => {
              cy.visit('http://frontend/');
              cy.get('h2.ant-typography').contains('(Re)Sources Relationnelles');
       });
});
