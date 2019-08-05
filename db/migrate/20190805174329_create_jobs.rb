class CreateJobs < ActiveRecord::Migration[5.1]
  def change
    create_table :jobs do |t|
      t.string :title
      t.integer :salary
      t.string :company
      t.string :location
      t.string :link
      t.string :job_website

      t.timestamps
    end
  end
end
