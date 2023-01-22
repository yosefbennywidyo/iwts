class CreateClients < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      with_options null: false, id: false, primary_key: :code do
        t.string :code
        t.string :name
        t.string :email
      end

      t.timestamps
      t.index :code, unique: true
    end

    create_table :teams do |t|
      with_options null: false, id: false, primary_key: :code do
        t.string :code
        t.string :name
        t.string :email
      end

      t.timestamps
      t.index :code, unique: true
    end

    create_table :stocks do |t|
      with_options null: false, id: false, primary_key: :code do
        t.string :code
        t.string :name
        t.string :email
      end

      t.timestamps
      t.index :code, unique: true
    end
  end
end
