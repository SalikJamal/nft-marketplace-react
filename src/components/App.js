import React, { useEffect, useState } from 'react'
import detectEthereumProvider from '@metamask/detect-provider'
import DarkPhantom from '../abis/DarkPhantom.json'
import Web3 from 'web3'
import { MDBCard, MDBCardBody, MDBCardImage, MDBCardText, MDBCardTitle, MDBBtn } from 'mdb-react-ui-kit'
import './App.css'


const App = () => {
  
  const [account, setAccount] = useState('')
  const [dpContract, setDPContract] = useState('')
  const [darkPhantomz, setDarkPhantomz] = useState([])

  // First is to detect an Ethereum provider
  const loadWeb3 = async () => {

    const provider = await detectEthereumProvider()
    if(provider) {
      console.log("Ethereum wallet is connected")
      window.web3 = new Web3(provider)
      loadBlockchainData()
    } else {
      console.log("No Ethereum wallet detected!")
    }

  }

  const loadBlockchainData = async () => {

    const web3 = window.web3
    const ethereum = window.ethereum

    const accounts = await ethereum.request({ method: 'eth_requestAccounts' })
    setAccount(accounts[0])

    const networkId = await web3.eth.net.getId()
    const networkData = DarkPhantom.networks[networkId]    

    if(networkData) {

      const abi = DarkPhantom.abi
      const address = networkData.address
      const contract = await new web3.eth.Contract(abi, address)
      setDPContract(contract)

      const totalSupply = await contract.methods.totalSupply().call()

      for(let i = 0; i <= totalSupply; i++) {
        const DP = await contract.methods.darkPhantomz(i).call()
        setDarkPhantomz(oldArray => [...oldArray, DP])
      }

    } else {
      window.alert('Smart contract not deployed')
    }

  }

  const mint = darkPhantom => {
    dpContract.methods.mint(darkPhantom).send({ from: account }).once('receipt', receipt => {
      setDarkPhantomz(oldArray => [...oldArray, DarkPhantom]) 
    })
  }

  const handleForm = event => {
    event.preventDefault()
    mint(event.target.darkPhantom.value)
  }

  useEffect(() => {
    loadWeb3()
  }, [])

  return (
    <div className='container-filled'>

      <nav className='navbar navbar-dark bg-dark fixed-top flex-md-nowrap p-0 shadow'>
        <div className='navbar-brand col-sm-3 col-md-3 mr-0 p-2 text-left'>
          Dark Phantom NFTs
        </div>
        <ul className='navbar-nav px-3'>
          <li className='nav-item text-nowrap d-sm-block'>
            <small className='text-white'>{account}</small>
          </li>
        </ul>
      </nav>

      <div className='container-fluid mt-1' style={{ width: '50%' }}>
        <div className='row'>
          <main className='col-lg-12' role='main'>
            <div className='content mr-auto ml-auto text-center' style={{ opacity: 0.8 }}>
              <h1>DarkPhantomz - NFT Marketplace</h1>
              <form onSubmit={handleForm}>
                <input className='form-control mb-1' type='text' name='darkPhantom' placeholder='Add file location' />
                <input className='btn btn-primary btn-black' style={{ margin: 6 }} type='submit' value='MINT' />
              </form>
            </div>
          </main>
        </div>
      </div>

      <hr></hr>
      <div className='row text-center'>
        {darkPhantomz.map((DP, key) => {
            return (
              <MDBCard key={key} className='token img' style={{ maxWidth: '22rem' }}>
                <MDBCardImage src={DP} position='top' height='250rem' style={{ marginRight: 4 }} />
                <MDBCardBody>
                <MDBCardTitle> DarkPhantomz </MDBCardTitle> 
                <MDBCardText> The DarkPhantomz are 20 uniquely generated Phantomz from the cyberpunk cloud galaxy Mystopia! There is only one of each phantom and each phantom can be owned by a single person on the Ethereum blockchain. </MDBCardText>
                <MDBBtn href={DP}>Download</MDBBtn>
                </MDBCardBody>
              </MDBCard>
            )
        })}
      </div>

    </div>
  )

}


export default App

/*
<img src="https://i.ibb.co/jWg9Mg4/k1.png" alt="k1" border="0">
<img src="https://i.ibb.co/sPJzPYq/k2.png" alt="k2" border="0">
<img src="https://i.ibb.co/W26K7n5/k3.png" alt="k3" border="0">
<img src="https://i.ibb.co/L1g7kPC/k4.png" alt="k4" border="0">
<img src="https://i.ibb.co/rcZZbKk/k5.png" alt="k5" border="0">
<a href="https://imgbb.com/"><img src="https://i.ibb.co/G2DMgH6/k6.png" alt="k6" border="0">
<img src="https://i.ibb.co/v1Ybkjf/k7.png" alt="k7" border="0">
<img src="https://i.ibb.co/4PnpwhF/k8.png" alt="k8" border="0">
<img src="https://i.ibb.co/hfr8MW7/k9.png" alt="k9" border="0">
<img src="https://i.ibb.co/SVRjDFs/k10.png" alt="k10" border="0">
<img src="https://i.ibb.co/6tDXBm9/k11.png" alt="k11" border="0">
 */