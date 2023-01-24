module Params
  class IndexParams < ApplicationService
    def initialize(params)
      @params = params
    end

    def call
      setup_index_params
    end
    
    private

    def setup_index_params
      if @params[:user_code].present?
        credit        = Credit.where(owner_id: @params[:user_code]).all
        debit         = Debit.where(owner_id: @params[:user_code]).all
        current_user  = Params::SetCurrentUser.call(user_code: @params[:user_code]).first
      elsif @params[:team_code].present?
        credit        = Credit.where(owner_id: @params[:team_code]).all
        debit         = Debit.where(owner_id: @params[:team_code]).all
        current_user  = Params::SetCurrentUser.call(team_code: @params[:team_code]).first
      elsif @params[:stock_code].present?
        credit        = Credit.where(owner_id: @params[:stock_code]).all
        debit         = Debit.where(owner_id: @params[:stock_code]).all
        current_user  = Params::SetCurrentUser.call(stock_code: @params[:stock_code]).first
      end

      return current_user, debit, credit
    end
  end
end