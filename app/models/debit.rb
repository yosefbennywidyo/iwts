class Debit < TransactionHistory
  validates :amount, numericality: {only_numeric: true, greater_than: 0}
  
  after_commit(on: :create) do
    self.wallet.update(balance: self.wallet.balance + self.amount)
  end
end
