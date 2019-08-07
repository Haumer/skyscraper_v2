class AddLocationToSearch < ActiveRecord::Migration[5.1]
  def change
    add_column :searches, :location, :string
  end
end
