it("Navigates to scented blade", () => {
  cy.visit('/');
  cy.contains("Scented").click();
});
it("Navigates to giant tea", () => {
  cy.visit('/');
  cy.contains("Giant").click();
});