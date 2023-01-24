require 'rails_helper'

RSpec.describe "teams/index", type: :view do
  let(:random) {
    SecureRandom.alphanumeric
  }

  let(:team_one) {
    Team.create!(name: "Team Test-#{random}1", email: "team_test-#{random}1@test.com")
  }

  let(:team_two) {
    Team.create!(name: "Team Test-#{random}2", email: "team_test-#{random}2@test.com")
  }

  before(:each) do
    assign(:teams, [
      team_one,
      team_two
    ])
  end

  it "renders a list of teams" do
    render

    expect(rendered).to have_selector("h1", text: "Teams")

    expect(rendered).to have_selector("p", text: " #{team_one.name}")
    expect(rendered).to have_selector("p", text: " #{team_one.email}")
    expect(rendered).to have_selector("p", text: " #{team_two.name}")
    expect(rendered).to have_selector("p", text: " #{team_two.email}")

    expect(rendered).to have_selector("p>a", text: "Show #{team_one.name}")
    expect(rendered).to have_selector("p>a", text: "Show #{team_two.name}")
    expect(rendered).to have_selector("p>a", text: "Use #{team_one.name} to create transaction")
    expect(rendered).to have_selector("p>a", text: "Use #{team_two.name} to create transaction")

    expect(rendered).to have_selector("a", text: "New team")
    expect(rendered).to have_selector("a", text: "Go to users")
    expect(rendered).to have_selector("a", text: "Go to teams")
    expect(rendered).to have_selector("a", text: "Go to stocks")
  end
end
