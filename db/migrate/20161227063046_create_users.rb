class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :email
      t.string :last_name
      t.string :first_name
      t.string :nickname
      t.string :country
      t.date :date_of_birth

      t.timestamps
    end
    add_index :users, :email
    add_index :users, :last_name
    add_index :users, :first_name
    # nickname, country, and date_of_birth do not have indexes on purpose.
  end
end
