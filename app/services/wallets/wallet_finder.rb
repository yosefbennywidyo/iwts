module Wallets
  class WalletFinder < ApplicationService
    def initialize(client_id={})
      @client_id = client_id
    end

    def call
      find_wallet
    end
    
    private

    def find_wallet
      wallet = Wallet.lock.find_by_address(@client_id)
      
      return wallet if wallet
    end
  end
end