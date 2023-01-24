require 'rails_helper'

RSpec.describe "home/index.html.erb", type: :view do
  it "renders a home#index" do
    render

    expect(rendered).to have_selector("h1", text: "Welcome to Internal Wallet Transactional System")

    expect(rendered).to have_selector("p", text: "You can start your transaction by select this options")

    expect(rendered).to have_selector("a", text: "Go to users")
    expect(rendered).to have_selector("a", text: "Go to teams")
    expect(rendered).to have_selector("a", text: "Go to stocks")
  end
end
