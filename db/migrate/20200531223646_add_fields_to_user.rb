class AddFieldsToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :api_access, :boolean, default: false, nil: false
    add_column :users, :active_search, :boolean, default: false, nil: false
    add_column :users, :github_username, :string, default: false, nil: false
  end
end
