require 'rails_helper'

RSpec.describe "wallets/show", type: :view do
  before(:each) do
    assign(:wallet, Wallet.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
