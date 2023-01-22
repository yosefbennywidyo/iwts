require 'rails_helper'

RSpec.describe "transaction_histories/edit", type: :view do
  let(:transaction_history) {
    TransactionHistory.create!()
  }

  before(:each) do
    assign(:transaction_history, transaction_history)
  end

  it "renders the edit transaction_history form" do
    render

    assert_select "form[action=?][method=?]", transaction_history_path(transaction_history), "post" do
    end
  end
end
