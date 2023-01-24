module Wallets
  class WalletOwner < ApplicationService
    def initialize(wallet={})
      @wallet = wallet
    end

    def call
      find_wallet_owner(@wallet)
    end
    
    private

    def find_wallet_owner(wallet)
      if wallet.user.present?
        return wallet.user.code
      elsif wallet.team.present?
        return wallet.team.code
      elsif wallet.stock.present?
        return wallet.stock.code
      else
        return nil
      end      
    end
  end
end