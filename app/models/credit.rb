class Credit < TransactionHistory
  validates :amount, numericality: {only_numeric: true, greater_than: 0}

  before_create do
    self.amount = self.amount * -1
  end

  after_commit(on: :create) do
    ActiveRecord::Base.transaction do
      sender_wallet = Wallets::WalletFinder.call(self.sender_id)

      receiver_wallet = Wallets::WalletFinder.call(self.receiver_id)
      receiver_wallet.update(balance: receiver_wallet.balance + (self.amount * -1))
      sender_wallet.update(balance: sender_wallet.balance - (self.amount * -1))

      unless self.receiver_id == "withdrawal" || self.receiver_id == 'topup'
        debit_amount = (self.amount * -1).to_d
        
        debit = Debit.new(
          amount: debit_amount,
          sender_id: self.sender_id,
          receiver_id: self.receiver_id,
          description: self.description
        )

        debit.owner_id = Wallets::WalletOwner.call(receiver_wallet)
        debit.save
      end
    end
  end
end
