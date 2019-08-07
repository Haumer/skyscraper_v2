class AddDescriptionClassToScraper < ActiveRecord::Migration[5.1]
  def change
    add_column :scrapers, :description_class, :string
  end
end
