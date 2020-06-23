class AddActiveToWebsite < ActiveRecord::Migration[5.1]
  def change
    add_column :websites, :active, :boolean, default: false
  end
end
