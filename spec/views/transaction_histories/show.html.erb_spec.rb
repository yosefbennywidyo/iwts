require 'rails_helper'

RSpec.describe "transaction_histories/show", type: :view do
  before(:each) do
    assign(:transaction_history, TransactionHistory.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
