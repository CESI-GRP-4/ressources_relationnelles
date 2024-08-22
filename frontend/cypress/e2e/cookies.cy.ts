import { waitAndClick } from './utils';

describe('Cookies', () => {
    it("Check if the cookies consent is null when the user hasn't accepted or declined the cookies", () => {
            cy.visit('http://91.108.112.237:3001');
            cy.getCookie('cookieConsent').should('be.null');
        }
    );
    it('Check if the cookies consent is set to "accepted" after clicking on the "Accept" button', () => {
        cy.visit('http://91.108.112.237:3001');
        waitAndClick('div > .ant-btn-primary > span');
        cy.getCookie('cookieConsent').should("exist");
        cy.getCookie('cookieConsent').should('have.property', 'value', 'true');
    });

    it('Check if the cookies consent is null after clicking on the "Decline" button. A session variable should exist with value false', () => {
        cy.visit('http://91.108.112.237:3001');
        cy.get('div > .ant-btn-default > span').should('be.visible').click();

        // the cookie should not exist and the session storage should be set to 'false'
        cy.getCookie('cookieConsent').should('be.null');
        cy.window().then((window) => {
            expect(window.sessionStorage.getItem('cookieConsent')).to.eq('false');
        });
    });
});