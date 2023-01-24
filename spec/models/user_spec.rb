require 'rails_helper'

RSpec.describe User, type: :model do
  let(:random) {
    SecureRandom.alphanumeric
  }

  subject {
    described_class.new(email: "user-test-#{random}@test.com", name: "User Test-#{random}", created_at: DateTime.now)
  }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid when email not unique" do
    User.create!(email: "user-test-#{random}@test.com", name: "User Test-#{random}")
    expect(subject).to_not be_valid
  end

  it "is not valid when name not unique" do
    User.create!(email: "user-test-#{random}@test.com", name: "User Test-#{random}")
    expect(subject).to_not be_valid
  end
end
