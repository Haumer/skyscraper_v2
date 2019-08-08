class AddCounterStartToScrapers < ActiveRecord::Migration[5.1]
  def change
    add_column :scrapers, :counter_start, :string
  end
end
