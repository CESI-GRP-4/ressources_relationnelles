describe('Test login champs vide', () => {
  it('Login avec champs vide', () => {
    cy.visit('http://localhost:3000/login')
    cy.get('#logInForm_email').type(' ')
    cy.get('#logInForm_password').type(' ')
    cy.get(':nth-child(4) > .ant-row > .ant-col > .ant-form-item-control-input > .ant-form-item-control-input-content > .ant-btn > span').click
  })
})