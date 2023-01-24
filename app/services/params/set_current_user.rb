module Params
  class SetCurrentUser < ApplicationService
    def initialize(params)
      @params = params
    end

    def call
      set_current_user
    end
    
    private

    def set_current_user      
      if @params[:user_code].present?
        if TransactionHistory.where(
            "owner_id LIKE ? OR sender_id LIKE ? OR receiver_id LIKE ?", @params[:user_code], @params[:user_code], @params[:user_code]
          ).present?
          current_user  = User.includes(:transaction_histories).find_by_code(@params[:user_code])
        else
          current_user  = User.find_by_code(@params[:user_code])
        end

        current_user_type = 'user'
      elsif @params[:team_code].present?
        if TransactionHistory.where(
            "owner_id LIKE ? OR sender_id LIKE ? OR receiver_id LIKE ?", @params[:team_code], @params[:team_code], @params[:team_code]
          ).present?
          current_user  = Team.includes(:transaction_histories).find_by_code(@params[:team_code])
        else
          current_user  = Team.find_by_code(@params[:team_code])
        end

        current_user_type = 'team'
      elsif @params[:stock_code].present?
        if TransactionHistory.where(
            "owner_id LIKE ? OR sender_id LIKE ? OR receiver_id LIKE ?", @params[:stock_code], @params[:stock_code], @params[:stock_code]
          ).present?
          current_user  = Stock.includes(:transaction_histories).find_by_code(@params[:stock_code])
        else
          current_user  = Stock.find_by_code(@params[:stock_code])
        end
        current_user_type = 'stock'
      end

      return current_user, current_user_type
    end
  end
end