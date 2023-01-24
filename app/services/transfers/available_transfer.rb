module Transfers
  class AvailableTransfer < ApplicationService
    def initialize(current_user)
      @current_user = current_user
    end

    def call
      setup_available_transfer
    end
    
    private

    def setup_available_transfer
      transfer_list, code_list = [], []
      code_list << User.all.pluck(:code)
      code_list << Team.all.pluck(:code)
      code_list << Stock.all.pluck(:code)
      code_list.flatten!
      code_list.delete_at(code_list.find_index(@current_user.code))
      transfer_list = Wallet.where(owner_id: code_list).pluck(:address)
      
      return transfer_list
    end
  end
end