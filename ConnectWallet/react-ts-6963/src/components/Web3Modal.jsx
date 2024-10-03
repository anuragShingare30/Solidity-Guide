import React from 'react'
import {
    useWeb3ModalAccount,
    useWeb3ModalProvider,
    createWeb3Modal,
    defaultConfig,
  } from 'web3modal-web3js/react';
  import { useState } from 'react';
import Web3 from 'web3';

// 1. Get projectId at https://cloud.walletconnect.com
const projectId = '63bed5b17c5efb17a261a2f5862f6567';

// 2. Set chains
const chains = [
    {
      chainId: 1,
      name: 'Ethereum',
      currency: 'ETH',
      explorerUrl: 'https://etherscan.io',
      rpcUrl: 'https://cloudflare-eth.com',
    },
    {
      chainId: 42161,
      name: 'Arbitrum',
      currency: 'ETH',
      explorerUrl: 'https://arbiscan.io',
      rpcUrl: 'https://arb1.arbitrum.io/rpc',
    },
    {
      chainId: 8453,
      name: 'Base',
      currency: 'ETH',
      explorerUrl: 'https://arbiscan.io',
      rpcUrl: 'https://base-rpc.publicnode.com',
    },
  ];

  const web3Config = defaultConfig({
    metadata: {
      name: 'Web3Modal',
      description: 'Web3Modal Laboratory',
      url: 'https://web3modal.com',
      icons: ['https://avatars.githubusercontent.com/u/37784886'],
    },
    defaultChainId: 1,
    rpcUrl: 'https://cloudflare-eth.com',
  });

  // 3. Create modal
  createWeb3Modal({
    web3Config,
    chains,
    projectId,
    enableAnalytics: true,
    themeMode: 'light',
    themeVariables: {
      '--w3m-color-mix': '#00DCFF',
      '--w3m-color-mix-strength': 20,
    },
  });

const Web3Modal = () => {
    // 4. Use modal hook
    const { address, chainId, isConnected } = useWeb3ModalAccount();
    const { walletProvider } = useWeb3ModalProvider();
    // useState to handle USDTBalance
    const [USDTBalance, setUSDTBalance] = useState(0); 
    const [smartContractName, setSmartContractName] = useState(''); 


    // THIS IS AN EXAMPLE FOR INTERACTING WITH SMART CONTRACT WITH WEB3.JS
    async function getBalance() {
        if (!isConnected) throw Error('not connected');
        const web3 = new Web3({
          provider: walletProvider,
          config: { defaultNetworkId: chainId },
        });
        const contract = new web3.eth.Contract(ERC20ABI, USDCAddress);
        const balance = await contract.methods.balanceOf(address).call();
        const name = string(await contract.methods.name().call());
        setUSDTBalance(Number(balance));
        setSmartContractName(name);
      }

  return (
    <div className="flex flex-col items-center gap-7 m-20 p-8 bg-white rounded-xl">
        <w3m-button />
        <w3m-network-button />
    </div>
  )
}

export {Web3Modal};
