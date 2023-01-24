require 'rails_helper'

RSpec.describe "stocks/index", type: :view do
  let(:random) {
    SecureRandom.alphanumeric
  }

  let(:stock_one) {
    Stock.create!(name: "Stock Test-#{random}1", email: "stock_test-#{random}1@test.com")
  }

  let(:stock_two) {
    Stock.create!(name: "Stock Test-#{random}2", email: "stock_test-#{random}2@test.com")
  }

  before(:each) do
    assign(:stocks, [
      stock_one,
      stock_two
    ])
  end

  it "renders a list of stocks" do
    render

    expect(rendered).to have_selector("h1", text: "Stocks")

    expect(rendered).to have_selector("p", text: " #{stock_one.name}")
    expect(rendered).to have_selector("p", text: " #{stock_one.email}")
    expect(rendered).to have_selector("p", text: " #{stock_two.name}")
    expect(rendered).to have_selector("p", text: " #{stock_two.email}")

    expect(rendered).to have_selector("p>a", text: "Show #{stock_one.name}")
    expect(rendered).to have_selector("p>a", text: "Show #{stock_two.name}")
    expect(rendered).to have_selector("p>a", text: "Use #{stock_one.name} to create transaction")
    expect(rendered).to have_selector("p>a", text: "Use #{stock_two.name} to create transaction")

    expect(rendered).to have_selector("a", text: "New stock")
    expect(rendered).to have_selector("a", text: "Go to users")
    expect(rendered).to have_selector("a", text: "Go to teams")
    expect(rendered).to have_selector("a", text: "Go to stocks")
  end
end
