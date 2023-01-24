require 'rails_helper'

RSpec.describe "teams/show", type: :view do
  let(:random) {
    SecureRandom.alphanumeric
  }

  let(:team) {
    Team.create!(name: "Team Test-#{random}", email: "team_test-#{random}@test.com")
  }

  before(:each) do
    assign(:team, team)
  end

  it "renders team attributes" do
    render

    expect(rendered).to have_selector("p", text: " #{team.name}")
    expect(rendered).to have_selector("p", text: " #{team.email}")

    expect(rendered).to have_selector("div>a", text: "Edit this team")
    expect(rendered).to have_selector("div>a", text: "Back to teams")
    expect(rendered).to have_selector("form>button", text: "Destroy this team")
  end
end
