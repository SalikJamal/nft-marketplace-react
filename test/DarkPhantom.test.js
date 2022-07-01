// Import chai module for testing
require('chai').use(require('chai-as-promised')).should()
const { assert } = require('chai')

// Importing contracts
const DarkPhantom = artifacts.require('DarkPhantom')


contract('DarkPhantom', accounts => {

    let darkPhantom

    // Before tells our tests to run this first before anything else
    before(async () => {
        darkPhantom = await DarkPhantom.deployed()
    })

    it('Deployment Status', () => {
        const address = darkPhantom.address
        assert.notEqual(address, ('' || null || undefined || 0x0), 'Contract address is not correct')
    })

    it('Correct Contract Name', async () => {
        const name = await darkPhantom.name()
        assert.equal(name, 'DarkPhantom', 'Contract name is not correct')
    })

    it('Correct Contract Symbol', async () => {
        const symbol = await darkPhantom.symbol()
        assert.equal(symbol, 'DPHANTOMZ', 'Contract symbol is not correct')
    })

    it('Minting: Creates a new token', async () => {
        const result = await darkPhantom.mint('https...1')
        const totalSupply = await darkPhantom.totalSupply()
        const event = result.logs[0].args

        // Success
        assert.equal(totalSupply, 1, 'Token supply is not correct')
        assert.equal(event._from, '0x0000000000000000000000000000000000000000', '_from is not the contract address')
        assert.equal(event._to, accounts[0], '_to is not msg.sender')

        // Failure
        await darkPhantom.mint('https...1').should.be.rejected
    })

    it('Indexing: Lists DPhantomz', async () => {
        
        // Mint three new tokens
        await darkPhantom.mint('https...2')
        await darkPhantom.mint('https...3')
        await darkPhantom.mint('https...4')
        const totalSupply = await darkPhantom.totalSupply()

        // Loop through list and grab DPhantomz from list
        let result = []
        let DarkPhantom

        for(let i = 0; i <= totalSupply; i++) {
            DarkPhantom = await darkPhantom.darkPhantomz(i)
            result.push(DarkPhantom)
        }
        
    })

})