class AddWebsiteToJobs < ActiveRecord::Migration[5.1]
  def change
    add_reference :jobs, :website, foreign_key: true
  end
end
