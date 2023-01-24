require 'rails_helper'

RSpec.describe "stocks/edit", type: :view do
  let(:random) {
    SecureRandom.alphanumeric
  }

  let(:stock) {
    Stock.create!(name: "Stock Test-#{random}", email: "stock_test-#{random}@test.com")
  }

  before(:each) do
    assign(:stock, stock)
  end

  it "renders the edit stock form" do
    render

    assert_select "form[action=?][method=?]", stock_path(stock), "post" do
    end
  end
end
