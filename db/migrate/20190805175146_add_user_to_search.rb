class AddUserToSearch < ActiveRecord::Migration[5.1]
  def change
    add_reference :searches, :user, foreign_key: true
  end
end
