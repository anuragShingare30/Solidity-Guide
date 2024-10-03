import React from 'react';
import { DiscoverWalletProviders } from "./DiscoverWalletProviders";
import { Web3Modal } from './Web3Modal';

const App = () => {
  return (
    <div>
      <DiscoverWalletProviders/> 
      <Web3Modal/>
    </div>
  )
}

export default App; 
