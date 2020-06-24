class MigrateJobsToSearchJobs < ActiveRecord::Migration[5.1]
  def up
    Job.find_each do |job|
      SearchJob.create(job: job, search: job.search)
    end
    remove_reference :jobs, :search, foreign_key: true
  end

  def down
    add_reference :jobs, :search, foreign_key: true
    SearchJob.find_each do |searchjob|
      searchjob.destroy if search_job.job.update(search: search_job.search)
    end
  end
end
