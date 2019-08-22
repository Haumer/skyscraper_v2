class AddQualityToJob < ActiveRecord::Migration[5.1]
  def change
    add_column :jobs, :quality, :integer, default: -1
  end
end
