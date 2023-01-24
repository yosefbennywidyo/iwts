require 'rails_helper'

RSpec.describe Wallet, type: :model do
  subject {
    described_class.new(owner_id: "#{Digest::MD5.hexdigest "User Test-3"}", balance: 0.0, created_at: DateTime.now)
  }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid when owner_id not unique" do
    Wallet.create!(owner_id: "#{Digest::MD5.hexdigest "User Test-3"}")
    expect(subject).to_not be_valid
  end
end
