require 'rails_helper'

RSpec.describe "stocks/edit", type: :view do
  let(:stock) {
    Stock.create!()
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
