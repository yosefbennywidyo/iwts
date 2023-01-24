require 'rails_helper'

RSpec.describe Team, type: :model do
  let(:random) {
    SecureRandom.alphanumeric
  }

  subject {
    described_class.new(email: "team-test-#{random}@test.com", name: "Team Test-#{random}", created_at: DateTime.now)
  }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid when email not unique" do
    Team.create!(email: "team-test-#{random}@test.com", name: "Team Test-#{random}")
    expect(subject).to_not be_valid
  end

  it "is not valid when name not unique" do
    Team.create!(email: "team-test-#{random}@test.com", name: "Team Test-#{random}")
    expect(subject).to_not be_valid
  end
end
