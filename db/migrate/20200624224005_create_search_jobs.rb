class CreateSearchJobs < ActiveRecord::Migration[5.1]
  def change
    create_table :search_jobs do |t|
      t.references :search, foreign_key: true
      t.references :job, foreign_key: true

      t.timestamps
    end
  end
end
