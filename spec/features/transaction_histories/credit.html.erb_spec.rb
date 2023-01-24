require 'rails_helper'

RSpec.feature "users/:user_code/transaction_histories/debit", type: :features do
  before(:all) do
    random = SecureRandom.alphanumeric
    User.create!(name: "User-#{random}", email: "user-#{random}@test.com")
    Team.create!(name: "Team-#{random}", email: "team-#{random}@test.com")
    Stock.create!(name: "Stock-#{random}", email: "stock-#{random}@test.com")
  end

  def setup_wallet_balance
    Debit.create!(amount: 1000, owner_id: User.first.code, sender_id: User.first.wallet.address, receiver_id: "topup")
    Debit.create!(amount: 1000, owner_id: Team.first.code, sender_id: Team.first.wallet.address, receiver_id: "topup")
    Debit.create!(amount: 1000, owner_id: Stock.first.code, sender_id: Stock.first.wallet.address, receiver_id: "topup")
  end

  it "renders user credit" do
    visit credit_user_transaction_histories_url(User.first.code, {user_code: "#{User.first.code}"})

    find('h5', text: "Credit details")
    expect(page).to have_content("Receiver")
    expect(page).to have_content("Amount")
    expect(page).to have_content("Description")
    find_button('Simpan')
  end

  it "user with no balance unable to create credit" do
    visit("/users/#{User.first.code}/transaction_histories/credit")

    find_by_id('credit_receiver_id')
    find_by_id('credit_amount')
    find_by_id('credit_description')
    find_button('Simpan')

    select("withdrawal", from: "credit_receiver_id")
    fill_in("credit_amount", with: "10")
    fill_in("credit_description", with: "withdrawal")
    find_button('Simpan').click

    Capybara.using_wait_time 20 do
      expect(page).to have_content "You don't have sufficient funds"
    end
  end

  it "user input amount as character unable to create credit" do
    visit("/users/#{User.first.code}/transaction_histories/credit")

    find_by_id('credit_receiver_id')
    find_by_id('credit_amount')
    find_by_id('credit_description')
    find_button('Simpan')

    select("withdrawal", from: "credit_receiver_id")
    fill_in("credit_amount", with: "1x")
    fill_in("credit_description", with: "withdrawal")
    find_button('Simpan').click

    Capybara.using_wait_time 20 do
      expect(page).to have_content "Amount is not a number"
    end
  end

  it "user input amount as negative unable to create credit" do
    visit("/users/#{User.first.code}/transaction_histories/credit")

    find_by_id('credit_receiver_id')
    find_by_id('credit_amount')
    find_by_id('credit_description')
    find_button('Simpan')

    select("withdrawal", from: "credit_receiver_id")
    fill_in("credit_amount", with: -1)
    fill_in("credit_description", with: "withdrawal")
    find_button('Simpan').click

    Capybara.using_wait_time 20 do
      expect(page).to have_content "Amount must be greater than 0"
    end
  end

  it "user able to fill create credit" do
    setup_wallet_balance
    visit("/users/#{User.first.code}/transaction_histories/credit")

    find_by_id('credit_receiver_id')
    find_by_id('credit_amount')
    find_by_id('credit_description')
    find_button('Simpan')

    select("withdrawal", from: "credit_receiver_id")
    fill_in("credit_amount", with: "10")
    fill_in("credit_description", with: "withdrawal")
  end
end
