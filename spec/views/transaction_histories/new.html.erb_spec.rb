require 'rails_helper'

RSpec.describe "transaction_histories/new", type: :view do
  before(:each) do
    assign(:transaction_history, TransactionHistory.new())
  end

  it "renders new transaction_history form" do
    render

    assert_select "form[action=?][method=?]", transaction_histories_path, "post" do
    end
  end
end
