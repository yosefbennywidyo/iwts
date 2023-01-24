require 'rails_helper'

RSpec.describe "stocks/show", type: :view do
  let(:random) {
    SecureRandom.alphanumeric
  }

  let(:stock) {
    Stock.create!(name: "Stock Test-#{random}", email: "stock_test-#{random}@test.com")
  }
  
  before(:each) do
    assign(:stock, stock)
  end

  it "renders stock attributes" do
    render

    expect(rendered).to have_selector("p", text: " #{stock.name}")
    expect(rendered).to have_selector("p", text: " #{stock.email}")

    expect(rendered).to have_selector("div>a", text: "Edit this stock")
    expect(rendered).to have_selector("div>a", text: "Back to stocks")
    expect(rendered).to have_selector("form>button", text: "Destroy this stock")
  end
end
