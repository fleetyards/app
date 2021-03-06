describe('Fleet', () => {
  beforeEach(() => {
    cy.visit('/')

    cy.acceptCookies()
  })

  it('Shows Preview', () => {
    cy.clickNav('fleets-menu')
    cy.clickNav('fleet-preview')

    cy.url().should('include', '/fleets/preview/')

    cy.select('login').click()

    cy.url().should('include', '/login')

    cy.clickNav('fleets-menu')
    cy.clickNav('fleet-add')

    cy.url().should('include', '/login')

    cy.visit('/')

    cy.clickNav('fleets-menu')
    cy.clickNav('fleet-add')

    cy.url().should('include', '/login')
  })

  it('default workflow', () => {
    cy.clickNav('fleets-menu')
    cy.clickNav('fleet-preview')

    cy.url().should('include', '/fleets/preview/')

    cy.select('login').click()

    cy.url().should('include', '/login')

    cy.clickNav('fleets-menu')
    cy.clickNav('fleet-add')

    cy.url().should('include', '/login')

    cy.visit('/')

    cy.clickNav('fleets-menu')
    cy.clickNav('fleet-add')

    cy.url().should('include', '/login')

    cy.login()

    cy.url().should('include', '/fleets/add/')

    cy.select('input-fid').type('TestFleet1')
    cy.select('input-name').type('Test Fleet 1.')

    cy.select('fleet-save').click()

    cy.url().should('include', '/fleets/testfleet1/')

    cy.success('Your Fleet has been created.')

    cy.wait(500)

    cy.clickNav('fleet-settings')

    cy.select('fleet-delete').click()

    cy.acceptConfirm()

    cy.wait(500)

    cy.success('Your Fleet has been destroyed.')
  })
})
