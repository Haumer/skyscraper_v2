class CreateScraperErrors < ActiveRecord::Migration[5.1]
  def change
    create_table :scraper_errors do |t|
      t.string :message
      t.string :url
      t.string :keyword
      t.string :location
      t.references :scraper, foreign_key: true

      t.timestamps
    end
  end
end
