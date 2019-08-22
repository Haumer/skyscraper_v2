class RemoveDuplicatesJob < ApplicationJob
  queue_as :default

  def perform(search)
    @search = search
    @jobs = search.jobs
    @jobs.each do |job|
      @duplicates = Job.all.where(title: job.title).where(company: job.company).where(salary: job.salary).where(search_id: job.search_id)
      # unless @duplicates.zero?
      p @duplicates
        @duplicates[(1..-1)].each do |dup|
          dup.destroy
        end
      # end
    end
  end
end
