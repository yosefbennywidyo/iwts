class Wallet < ApplicationRecord
  self.primary_key = :address

  belongs_to :user, foreign_key: 'owner_id', primary_key: 'code', class_name: 'User', optional: true
  belongs_to :team, foreign_key: 'owner_id', primary_key: 'code', class_name: 'Team', optional: true
  belongs_to :stock, foreign_key: 'owner_id', primary_key: 'code', class_name: 'Stock', optional: true
  has_many :transaction_histories, foreign_key: 'sender_id', primary_key: 'address', class_name: 'TransactionHistory', strict_loading: true

  validates :owner_id, allow_blank: false, uniqueness: true
end
