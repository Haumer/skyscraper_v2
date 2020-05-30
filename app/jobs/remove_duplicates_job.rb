class RemoveDuplicatesJob < ApplicationJob
  queue_as :default

  def perform(id)
    @search = Search.find(id)
    @jobs = @search.jobs
    @jobs.each do |job|
      begin
        @duplicates = Job.all.where(title: job.title).where(company: job.company).where(salary: job.salary).where(search_id: job.search_id)
        if @duplicates.nil?
          puts "#{@duplicates.first.title} has no duplicates"
        else
          @duplicates[(1..-1)].each do |dup|
            dup.destroy
          end
        end
      rescue StandardError => e
        puts e.message
      end
    end
  end
end
