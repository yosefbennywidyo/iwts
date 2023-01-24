require 'rails_helper'

RSpec.describe "teams/edit", type: :view do
  let(:random) {
    SecureRandom.alphanumeric
  }

  let(:team) {
    Team.create!(name: "Team Test-#{random}", email: "team_test-#{random}@test.com")
  }

  before(:each) do
    assign(:team, team)
  end

  it "renders the edit team form" do
    render

    assert_select "form[action=?][method=?]", team_path(team), "post" do
    end
  end
end
