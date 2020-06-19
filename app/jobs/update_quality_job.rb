class UpdateQualityJob < ApplicationJob
  queue_as :default

  def perform(id)
    @search = Search.find(id)
    @search.jobs.each do |job|
      quality = Quality.new(job, @search)
      quality.check
      job.save
    end
  end

  private

  class Quality
    def initialize(job, search)
      @job = job
      @search = search
      @job.quality = -1
    end

    def check
      salary_quality
      location_quality
      title_quality
      description_quality
    end

    def salary_quality
      @job.salary.scan(/\d/).length < 4 ? @job.quality -= 1 : @job.quality += 1
      @job.quality += 2 if @job.salary.scan(/\d/).length > 6
    end

    def location_quality
      @job.quality -= 1 if @job.location.length < 20
    end

    def title_quality
      @job.quality += 1 if @job.title.downcase.include?("mid") || @job.title.downcase.include?("junior") || @job.title.downcase.include?("senior")
      @job.quality -= 1 if @job.title.length < 35
      @job.quality += 1 if @job.title.downcase.include?(@search.keyword.downcase)
      @job.quality -= 2 if @job.title.downcase.include?(@search.keyword.downcase) && @job.company.downcase.include?(@search.keyword.downcase)
    end

    def description_quality
      @job.quality += 1 if @job.description.downcase.include?(@search.keyword.downcase)
      @job.quality -= 10 unless @job.description.downcase.include?(@search.keyword.downcase)
    end
  end
end
