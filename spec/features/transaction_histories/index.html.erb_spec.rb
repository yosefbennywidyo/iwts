require 'rails_helper'

RSpec.feature "users/:user_code/transaction_histories/index", type: :features do
  before(:context) do
    User.create!(name: "User Test-1", email: "user_test-1@test.com")
    Team.create!(name: "Team Test-1", email: "team_test-1@test.com")
    Stock.create!(name: "Stock Test-1", email: "team_test-1@test.com")
    
    Debit.create!(owner_id: User.first.wallet.owner_id, sender_id: User.first.wallet.address, receiver_id: 'topup', amount: 100)
    Credit.create!(owner_id: User.first.wallet.owner_id, sender_id: User.first.wallet.address, receiver_id: Team.first.wallet.address, amount: 10)
    Debit.create!(owner_id: Team.first.wallet.owner_id, sender_id: Team.first.wallet.address, receiver_id: 'topup', amount: 100)
    Credit.create!(owner_id: Team.first.wallet.owner_id, sender_id: Team.first.wallet.address, receiver_id: Stock.first.wallet.address, amount: 10)
  end

  it "renders user list of transaction_histories" do
    visit(user_transaction_histories_path(User.first.code))

    find('h1', text: "#{User.first.name} Transaction Histories")
    find_link('Debit')
    find_link('Credit')

    Capybara.using_wait_time 20 do
      expect(page).to have_css('h3', text: 'Debit')
      expect(page).to have_css('h3', text: 'Credit')
      expect(page).to have_css('th', text: 'Sender', count: 2)
      expect(page).to have_css('th', text: 'Receiver', count: 2)
      expect(page).to have_css('th', text: 'Amount', count: 2)
      expect(page).to have_css('th', text: 'Description', count: 2)
      expect(page).to have_css('td', text: "#{User.first.wallet.address.truncate(10)}")
      expect(page).to have_css('td', text: "$100.00")
      expect(page).to have_css('td', text: "View #{Team.first.name} transaction histories")
      expect(page).to have_css('td', text: "$10.00")
    end

    find_link('Go to users')
    find_link('Go to teams')
    find_link('Go to stocks')
  end

  it "renders team list of transaction_histories" do
    visit(team_transaction_histories_path(Team.first.code))
    find('h1', text: "#{Team.first.name} Transaction Histories")
    find_link('Debit')
    find_link('Credit')

    Capybara.using_wait_time 20 do
      expect(page).not_to have_css('h3', text: 'Debit')
      expect(page).not_to have_css('h3', text: 'Credit')
      expect(page).not_to have_css('th', text: 'Sender', count: 2)
      expect(page).not_to have_css('th', text: 'Receiver', count: 2)
      expect(page).not_to have_css('th', text: 'Amount', count: 2)
      expect(page).not_to have_css('th', text: 'Description', count: 2)
      expect(page).not_to have_css('td', text: "#{Team.first.wallet.address.truncate(10)}")
      expect(page).not_to have_css('td', text: "$100.00")
      expect(page).not_to have_css('td', text: "View #{Stock.first.name} transaction histories")
      expect(page).not_to have_css('td', text: "$10.00")
    end

    find_link('Go to users')
    find_link('Go to teams')
    find_link('Go to stocks')
  end

  it "renders stock list of transaction_histories" do
    visit(stock_transaction_histories_path(Stock.first.code))
    find('h1', text: "#{Stock.first.name} Transaction Histories")
    find_link('Debit')
    find_link('Credit')

    Capybara.using_wait_time 20 do
      expect(page).not_to have_css('h3', text: 'Debit')
      expect(page).not_to have_css('h3', text: 'Credit')
      expect(page).not_to have_css('th', text: 'Sender', count: 2)
      expect(page).not_to have_css('th', text: 'Receiver', count: 2)
      expect(page).not_to have_css('th', text: 'Amount', count: 2)
      expect(page).not_to have_css('th', text: 'Description', count: 2)
      expect(page).not_to have_css('td', text: "#{Stock.first.wallet.address.truncate(10)}")
      expect(page).not_to have_css('td', text: "100")
      expect(page).not_to have_css('td', text: "#{Stock.first.wallet.address.truncate(10)}")
      expect(page).not_to have_css('td', text: "10")
    end

    find_link('Go to users')
    find_link('Go to teams')
    find_link('Go to stocks')
  end
end
