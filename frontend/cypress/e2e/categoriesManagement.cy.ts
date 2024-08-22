import { waitAndClick, loginAsSuperAdmin } from './utils';

describe('Categories management', () => {
    it("Check if a super admin can access the categories management page", () => {
        loginAsSuperAdmin();
        cy.visit('http://91.108.112.237:3001/gestion-categories');
        cy.url().should('eq', 'http://91.108.112.237:3001/gestion-categories');
    });

    it("create a category ", () => {
        loginAsSuperAdmin();
        cy.visit('http://91.108.112.237:3001/gestion-categories');
        cy.url().should('eq', 'http://91.108.112.237:3001/gestion-categories');
        cy.get('.ant-btn > :nth-child(2)').should("be.visible").click();

        const randomTitle = generateRandomText(10); // Change 10 to the desired length of the random text
        const randomDescription = generateRandomText(50); // Change 10 to the desired length of the random text

        cy.get('#createCategoryForm_title').should('be.visible').type(randomTitle);
        cy.get('#createCategoryForm_description').should('be.visible').type(randomDescription);
        cy.get('#createCategoryForm_icon').should('be.visible').type(randomTitle);
        cy.get(':nth-child(2) > .ant-btn > span').should('be.visible').click();

        cy.get('.ant-card-body > .ant-card-meta > .ant-card-meta-detail > .ant-card-meta-title').contains(randomTitle);
        cy.get('.ant-card-body > .ant-card-meta > .ant-card-meta-detail > .ant-card-meta-description').contains(randomDescription);
    })
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