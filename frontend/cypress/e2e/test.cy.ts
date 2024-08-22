import { generateRandomPassword, generateRandomEmail, generateRandomFirstName, generateRandomLastName } from "./utils";

describe('Home page pipeline', () => {
       it('zzzz', () => {
              cy.visit('http://localhost:3001/');
              cy.get('h2.ant-typography').contains('(Re)Sources Relationnelles');
       });
});
