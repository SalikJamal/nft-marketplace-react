import React, { useEffect, useState } from 'react'
import Web3 from 'web3'
import detectEthereumProvider from '@metamask/detect-provider'
// import DarkPhantom from '../abis/DarkPhantom.json'


const App = () => {
  
  const [account, setAccount] = useState('')

  // First is to detect an Ethereum provider
  const loadWeb3 = async () => {

    const provider = await detectEthereumProvider()
    if(provider) {
      console.log("Ethereum wallet is connected")
    } else {
      console.log("No Ethereum wallet detected!")
    }

  }

  const loadBlockchainData = async () => {
    const accounts = await window.ethereum.request({ method: 'eth_requestAccounts' })
    console.log(accounts[0])
  }

  useEffect(() => {
    loadWeb3()
    loadBlockchainData()
  }, [])

  return (
    <div>
      <h1>NFT Marketplace</h1>
    </div>
  )

}


export default App