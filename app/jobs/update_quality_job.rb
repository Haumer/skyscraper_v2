class UpdateQualityJob < ApplicationJob
  queue_as :default

  def perform(id)
    @search = Search.find(id)
    @jobs = @search.jobs
    @jobs.each do |job|
      job.quality = -1
      job.salary.scan(/\d/).length < 4 ? job.quality -= 1 : job.quality += 1
      job.quality += 2 if job.salary.scan(/\d/).length > 6
      job.quality -= 1 if job.title.length < 35
      job.quality -= 1 if job.location.length < 20
      job.quality += 1 if job.title.downcase.include?(@search.keyword.downcase)
      job.quality -= 2 if job.title.downcase.include?(@search.keyword.downcase) && job.company.downcase.include?(@search.keyword.downcase)
      job.quality += 1 if job.description.downcase.include?(@search.keyword.downcase)
      job.quality += 1 if job.title.downcase.include?("mid") || job.title.downcase.include?("junior") || job.title.downcase.include?("senior")
      job.save
    end
  end
end
