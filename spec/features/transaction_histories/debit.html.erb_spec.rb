require 'rails_helper'

RSpec.feature "users/:user_code/transaction_histories/debit", type: :features do
  before(:all) do
    random = SecureRandom.alphanumeric
    User.create!(name: "User-#{random}", email: "user-#{random}@test.com")
  end

  it "renders user debit" do
    visit("/users/#{User.first.code}/transaction_histories/debit")
    
    find('h5', text: "Debit details")
    expect(page).to have_content("Receiver")
    expect(page).to have_content("Amount")
    expect(page).to have_content("Description")
    find_button('Simpan')
  end

  it "user able to topup" do
    visit("/users/#{User.first.code}/transaction_histories/debit")

    find_field("debit_receiver_id")
    find_field("debit_amount")
    find_field("debit_description")
    find_button('Simpan')

    select("Topup", from: "debit_receiver_id")
    fill_in("Amount", with: "10")
    fill_in("Description", with: "Topup")
    find_button('Simpan').click

    expect(page).to have_content "Debit transaction success"
  end

  it "user input amount as character unable to create debit" do
    visit("/users/#{User.first.code}/transaction_histories/debit")

    find_by_id('debit_receiver_id')
    find_by_id('debit_amount')
    find_by_id('debit_description')
    find_button('Simpan')

    select("Topup", from: "debit_receiver_id")
    fill_in("debit_amount", with: "1x")
    fill_in("debit_description", with: "Topup")
    find_button('Simpan').click

    Capybara.using_wait_time 60 do
      expect(page).to have_content "Amount is not a number"
    end
  end

  it "user input amount as negative unable to create debit" do
    visit("/users/#{User.first.code}/transaction_histories/debit")

    find_by_id('debit_receiver_id')
    find_by_id('debit_amount')
    find_by_id('debit_description')
    find_button('Simpan')

    select("Topup", from: "debit_receiver_id")
    fill_in("debit_amount", with: -1)
    fill_in("debit_description", with: "Topup")
    find_button('Simpan').click

    Capybara.using_wait_time 60 do
      expect(page).to have_content "Amount must be greater than 0"
    end
  end

  it "user able to fill create debit" do
    visit("/users/#{User.first.code}/transaction_histories/debit")

    find_by_id('debit_receiver_id')
    find_by_id('debit_amount')
    find_by_id('debit_description')
    find_button('Simpan')

    select("Topup", from: "debit_receiver_id")
    fill_in("debit_amount", with: "10")
    fill_in("debit_description", with: "Topup")
  end
end
