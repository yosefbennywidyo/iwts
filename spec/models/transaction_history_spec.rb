require 'rails_helper'

RSpec.describe TransactionHistory, type: :model do
  let(:random) {
    SecureRandom.alphanumeric
  }

  let(:user) {
    User.create!(name: "User Test-#{random}", email: "user_test-#{random}@test.com")
  }

  let(:team) {
    Team.create!(name: "Team Test-#{random}", email: "team_test-#{random}@test.com")
  }

  subject {
    described_class.new(
      amount: 1000,
      type: "Credit",
      owner_id: user.code,
      sender_id: user.wallet.address,
      receiver_id: team.wallet.address,
      created_at: DateTime.now)
  }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid when amount is minus" do
    subject.amount = -1
    expect(subject).to_not be_valid
  end

  it "is not valid when amount is text" do
    subject.amount = "x"
    expect(subject).to_not be_valid
  end

  it "is not valid when amount is not a number" do
    subject.amount = "1x"
    expect(subject).to_not be_valid
  end
end
