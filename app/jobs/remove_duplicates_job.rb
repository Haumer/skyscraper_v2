class RemoveDuplicatesJob < ApplicationJob
  queue_as :default

  def perform(id)
    @search = Search.find(id)
    @search.jobs.each do |job|
      delete_duplicates(job)
    end
  end

  private

  def delete_duplicates(job)
    begin
      @duplicates = Job.where(title: job.title, company: job.company, salary: job.salary)
      puts "#{@duplicates.first.title} has no duplicates" if @duplicates.nil?
      @duplicates[(1..-1)]&.each { |dup| dup.destroy } if @duplicates
    rescue StandardError => e
      puts e.message
    end
  end
end
