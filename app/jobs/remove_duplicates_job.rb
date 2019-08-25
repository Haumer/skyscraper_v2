class RemoveDuplicatesJob < ApplicationJob
  queue_as :default

  def perform(search)
    @search = search
    @jobs = search.jobs
    begin
    @jobs.each do |job|
      @duplicates = Job.all.where(title: job.title).where(company: job.company).where(salary: job.salary).where(search_id: job.search_id)
      # unless @duplicates.zero?
      @duplicates[(1..-1)].each do |dup|
        dup.destroy
      end
    end
    rescue StandardError => e
      puts e.message
      puts url
    end
  end
end
