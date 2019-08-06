class AddNumberOfPagesToScrapers < ActiveRecord::Migration[5.1]
  def change
    add_column :scrapers, :nr_pages, :integer
  end
end
