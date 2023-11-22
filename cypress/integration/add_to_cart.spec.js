it("Adds product to cart", () => {
  cy.visit('/');
  cy.contains("Add").click({force: true});
  cy.visit('/cart');
  cy.get('.cart-show').should('have.length', 1)
});