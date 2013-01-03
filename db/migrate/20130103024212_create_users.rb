class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :salt
      t.string :hashed_password
      t.boolean :enabled
      t.text :profile
      t.string :company
      t.datetime :created_at
      t.datetime :updated_at
      t.datetime :last_login_at

      t.timestamps
    end
  end
end
