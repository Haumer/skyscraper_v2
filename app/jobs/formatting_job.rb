class FormattingJob < ApplicationJob
  queue_as :default
  after_perform :update_status_formatted

  def perform(search)
    @search = search
    search.jobs.each do |job|
      job.title.gsub(/\s/, " ")
      job.location.gsub(/\s/, " ")
      job.save
    end
  end

  private

  def update_status_formatted
    @search.update(status_scraped: true, status_message: "finished formatting")
  end
end
