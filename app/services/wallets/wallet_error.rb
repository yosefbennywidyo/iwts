module Wallets
  class WalletError < ApplicationService
    def initialize(params={})
      @client_error = params[:client_error]
      @error_type   = params[:error_type]
    end

    def call
      setup_returned_error
    end
    
    private

    def setup_returned_error
      if @error_type == 'fund'
        return "You don't have sufficient funds"
      elsif @error_type == 'amount'
        return "Please only input positive amount value"
      elsif @client_error.present?
        return "Unable to find #{@client_error} wallet"
      end
    end
  end
end