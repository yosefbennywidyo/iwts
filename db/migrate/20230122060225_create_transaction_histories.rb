class CreateTransactionHistories < ActiveRecord::Migration[7.0]
  def change
    create_table :transaction_histories, id: false, primary_key: :number do |t|
      t.decimal :amount
      t.string :type
      t.string :owner_id
      t.string :sender_id
      t.string :receiver_id
      t.string :number
      t.string :description

      t.timestamps
    end
  end
end
