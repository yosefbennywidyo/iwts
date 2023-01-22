class TransactionHistory < ApplicationRecord
  include SharedMethod

  self.primary_key = :number
  
  belongs_to :user, foreign_key: 'owner_id', primary_key: 'code', class_name: 'User', optional: true
  belongs_to :team, foreign_key: 'owner_id', primary_key: 'code', class_name: 'Team', optional: true
  belongs_to :stock, foreign_key: 'owner_id', primary_key: 'code', class_name: 'Stock', optional: true
  belongs_to :wallet, foreign_key: 'sender_id', primary_key: 'address', class_name: 'Wallet'

  before_create do
    self.number = generate_uniq_key({selected: 3})
  end
end
