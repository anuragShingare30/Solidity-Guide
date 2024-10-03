import React, { useState } from "react"
import { useSyncProviders } from "../hooks/useSyncProviders"
import { formatAddress } from "../utils/index";

export const DiscoverWalletProviders = () => {
  const [selectedWallet, setSelectedWallet] = useState();
  const [userAccount, setUserAccount] = useState<string>("")
  const providers = useSyncProviders()

  // Connect to the selected provider using eth_requestAccounts.
  const handleConnect = async (providerWithInfo: EIP6963ProviderDetail) => {
    try { 
      const accounts = await providerWithInfo.provider.request({
        method: "eth_requestAccounts"
      })
      console.log(selectedWallet);
      setSelectedWallet(providerWithInfo) 
      setUserAccount(accounts?.[0])
    } catch (error) {
      console.error(error)
    }
  }

  



  // Display detected providers as connect buttons.
  return (
    <div className="flex flex-col p-10 m-10">
      <div className="flex flex-col items-center gap-8">
        <h2 className="text-4xl text-white font-bold">Wallets Detected : </h2>
        <div className="flex flex-row gap-10 content-center">
          {
            providers.length > 0 ? providers?.map((provider: EIP6963ProviderDetail, index) => (
              <div className="flex flex-row items-center gap-4" key={index}>
                <img src={provider.info.icon} alt={provider.info.name} width="60px" />
                <button key={provider.info.uuid} onClick={() => handleConnect(provider)} className="btn btn-sm btn-primary">
                  <div>{provider.info.name}</div>
                </button>
              </div>
            )) :
              <div>
                No Announced Wallet Providers
              </div>
          }
        </div>
      </div>
      <hr />
      <h2 className="text-3xl text-white font-bold">{userAccount ? "" : "No "}Wallet Selected</h2>
      {userAccount &&
        <div>
          <div>
            <img src={selectedWallet.info.icon} alt={selectedWallet.info.name} width="50px" />
            <div>{selectedWallet.info.name}</div>
            <div>{userAccount}</div>
            <div>{}</div>
          </div>
        </div>
      }
    </div>
  )
}