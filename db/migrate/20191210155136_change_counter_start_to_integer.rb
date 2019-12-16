class ChangeCounterStartToInteger < ActiveRecord::Migration[5.1]
  def change
    remove_column :scrapers, :counter_start, :string
    add_column :scrapers, :counter_start, :integer
  end
end
