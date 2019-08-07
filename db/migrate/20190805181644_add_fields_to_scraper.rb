class AddFieldsToScraper < ActiveRecord::Migration[5.1]
  def change
    add_column :scrapers, :card_class, :string
    add_column :scrapers, :title_class, :string
    add_column :scrapers, :salary_class, :string
    add_column :scrapers, :location_class, :string
    add_column :scrapers, :link_class, :string
    add_column :scrapers, :company_class, :string
    add_column :scrapers, :scrape_url, :string
    add_column :scrapers, :counter_interval, :integer
  end
end
