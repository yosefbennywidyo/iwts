class CreateWallets < ActiveRecord::Migration[7.0]
  def change
    create_table :wallets, id: false, primary_key: :code do |t|
      t.string :address
      t.string :owner_id
      t.decimal :balance, precision: 8, scale: 2, default: 0

      t.timestamps
    end
  end
end
