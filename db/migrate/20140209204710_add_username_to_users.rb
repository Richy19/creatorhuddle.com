class AddUsernameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :username, :string

    User.find_each do |user|
      user.username = user.email
      user.save
    end

    change_column :users, :username, :string, null: false

    add_index :users, :username, unique: true
  end
end
