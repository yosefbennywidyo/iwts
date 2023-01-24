class TransactionHistoriesController < ApplicationController
  before_action :set_current_user, only: %i[ index new_debit new_credit debit credit ]

  # GET /transaction_histories or /transaction_histories.json
  def index
    current_user, @debits, @credits = Params::IndexParams.call(transaction_history_params)
    client                          = helpers.find_client_type_by_wallet(@current_user.wallet)
    @wallet_balance                 = client.find_by_code(@current_user.code).balance
    @transaction_histories          = User.includes(:transaction_histories).find_by_code(@current_user.code)
  end

  def new_debit
    #if transaction_history_params[:debit].present?
      @debit = Debit.new(transaction_history_params.except(:user_code, :team_code, :stock_code))

      if @debit.valid?
        check_balance
        if @debit.errors.any?
          redirect_back_or_to root_path, notice: @debit.errors.full_messages
        else
          @debit.save
          redirect_to "/#{helpers.find_client_type_by_wallet(@current_user.wallet).to_s.downcase}s/#{@current_user.code}/transaction_histories", notice: "Debit transaction success"
        end
      else
        redirect_back_or_to root_path, notice: @debit.errors.full_messages
      end
    #end
  end

  def new_credit
    #if transaction_history_params[:credit].present?
      @credit = Credit.new(transaction_history_params)
      
      
      if @credit.valid?
        check_balance
        if @credit.errors.any?
          redirect_back_or_to root_path, notice: @credit.errors.full_messages
        elsif @credit.valid?
          @credit.save
          redirect_to "/#{helpers.find_client_type_by_wallet(@current_user.wallet).to_s.downcase}s/#{@current_user.code}/transaction_histories", notice: "Credit transaction success"
        end
      else
        redirect_back_or_to root_path, notice: @credit.errors.full_messages
      end
    #end
  end

  def debit
    @debit  = Debit.new
  end

  def credit
    #binding.break
    @credit = Credit.new
  end

  private
    # Use callbacks to share common setup or constraints between actions.
=begin
    def set_transaction_history
      @transaction_history = TransactionHistory.find_by_number(params[:number])
    end
=end
    def set_current_user
      #binding.break
      @current_user, @user_type = Params::SetCurrentUser.call(params) 
      @transaction_histories    = TransactionHistory.where(owner_id: @current_user.code)
      
      set_available_transfer
    end

    def set_available_transfer
      @transfer_list ||= Transfers::AvailableTransfer.call(@current_user)
    end

    def check_amount
      if @credit.present? && transaction_history_params[:amount].to_d <= 0 && 
        @credit.errors.add(:base, Wallets::WalletError.call({error_type: "amount"}))
      elsif @debit.present? && transaction_history_params[:amount].to_d <= 0 && transaction_history_params[:amount].t
        @debit.errors.add(:base, Wallets::WalletError.call({error_type: "amount"}))
      else
        return true
      end
    end

    def check_balance
      setup_wallets

      if @credit.present?
        if transaction_history_params[:receiver_id] == "withdrawal" && @sender_wallet.balance < transaction_history_params[:amount].to_d
          @credit.errors.add(:base, Wallets::WalletError.call({error_type: "fund"}))
        elsif @sender_wallet.balance < transaction_history_params[:amount].to_d
          @credit.errors.add(:base, Wallets::WalletError.call({error_type: "fund"}))
        end
      end
    end
  
    def setup_wallets
      if transaction_history_params[:receiver_id] == "withdrawal" || transaction_history_params[:receiver_id] == "topup"
        sender_wallet   = Wallets::WalletFinder.call(transaction_history_params[:sender_id])
        receiver_wallet = sender_wallet
      else
        receiver_wallet = Wallets::WalletFinder.call(transaction_history_params[:receiver_id])
        sender_wallet   = Wallets::WalletFinder.call(transaction_history_params[:sender_id])
      end

      if sender_wallet.present? && receiver_wallet.present?
        @sender_wallet    = sender_wallet
        @receiver_wallet  = receiver_wallet
      elsif sender_wallet.blank?
        Wallets::WalletError.call({client_error: "sender"})
      elsif receiver_wallet.blank?
        Wallets::WalletError.call({client_error: "receiver"})
      end
    end

    # Only allow a list of trusted parameters through.
    def transaction_history_params
      params.fetch(:user_code, {})
      params.fetch(:team_code, {})
      params.fetch(:stock_code, {})
      if params[:debit].present?
        params.require(:debit).permit(:owner_id, :sender_id, :receiver_id, :amount, :description)
      elsif params[:credit].present?
        params.require(:credit).permit(:owner_id, :sender_id, :receiver_id, :amount, :description)
      else
        params.permit(:user_code, :team_code, :stock_code)
      end
    end
end
