class CreateWebsites < ActiveRecord::Migration[5.1]
  def change
    create_table :websites do |t|
      t.string :name
      t.string :base_url

      t.timestamps
    end
  end
end
