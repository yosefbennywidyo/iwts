require 'rails_helper'

RSpec.describe "users/index", type: :view do
  let(:random) {
    SecureRandom.alphanumeric
  }

  let(:user_one) {
    Team.create!(name: "User Test-#{random}1", email: "user_test-#{random}1@test.com")
  }

  let(:user_two) {
    Team.create!(name: "User Test-#{random}2", email: "user_test-#{random}2@test.com")
  }

  before(:each) do
    assign(:users, [
      user_one,
      user_two
    ])
  end

  it "renders a list of users" do
    render

    expect(rendered).to have_selector("h1", text: "Users")

    expect(rendered).to have_selector("p", text: " #{user_one.name}")
    expect(rendered).to have_selector("p", text: " #{user_one.email}")
    expect(rendered).to have_selector("p", text: " #{user_two.name}")
    expect(rendered).to have_selector("p", text: " #{user_two.email}")

    expect(rendered).to have_selector("p>a", text: "Show #{user_one.name}")
    expect(rendered).to have_selector("p>a", text: "Show #{user_two.name}")
    expect(rendered).to have_selector("p>a", text: "Use #{user_one.name} to create transaction")
    expect(rendered).to have_selector("p>a", text: "Use #{user_two.name} to create transaction")

    expect(rendered).to have_selector("a", text: "New user")
    expect(rendered).to have_selector("a", text: "Go to users")
    expect(rendered).to have_selector("a", text: "Go to teams")
    expect(rendered).to have_selector("a", text: "Go to stocks")
  end
end
