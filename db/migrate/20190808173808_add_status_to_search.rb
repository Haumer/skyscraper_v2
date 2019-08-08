class AddStatusToSearch < ActiveRecord::Migration[5.1]
  def change
    add_column :searches, :status, :boolean, default: nil
    add_column :searches, :status_message, :string, default: "searching for jobs"
  end
end
