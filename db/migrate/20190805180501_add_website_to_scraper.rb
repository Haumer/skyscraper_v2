class AddWebsiteToScraper < ActiveRecord::Migration[5.1]
  def change
    add_reference :scrapers, :website, foreign_key: true
  end
end
