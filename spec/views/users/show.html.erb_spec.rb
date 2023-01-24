require 'rails_helper'

RSpec.describe "users/show", type: :view do
  let(:random) {
    SecureRandom.alphanumeric
  }

  let(:user) {
    User.create!(name: "User Test-#{random}", email: "user_test-#{random}@test.com")
  }

  before(:each) do
    assign(:user, user)
  end

  it "renders user attributes" do
    render

    expect(rendered).to have_selector("p", text: " #{user.name}")
    expect(rendered).to have_selector("p", text: " #{user.email}")

    expect(rendered).to have_selector("div>a", text: "Edit this user")
    expect(rendered).to have_selector("div>a", text: "Back to users")
    expect(rendered).to have_selector("form>button", text: "Destroy this user")
  end
end
