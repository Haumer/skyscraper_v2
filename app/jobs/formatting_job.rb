class FormattingJob < ApplicationJob
  queue_as :default
  after_perform :update_status_formatted

  def perform(search)
    @search = search
    search.jobs.each do |job|
      job.update(title: job.title.gsub(/\s/, " "))
      job.update(location: job.location.gsub(/\s/, " "))
      if job.salary.gsub(/Â/,"").scan(/\d/).length < 4
        job.salary = "unspecified"
      else
        job.update!(salary: job.salary.gsub(/Â/,"").scan(/£?(\d+k|\d+\.\d+|\d+|\d+,\d+|\d+)( - | to |\s-\s)?£?(\d+k|\d+\.\d+|\d+,\d+|\d+)?/).join.gsub("to", "-").gsub("k", "000").gsub(",", "").gsub(".00",""))
      end
    end
  end
# change update into one db call
  private

  def update_status_formatted
    @search.update(status_scraped: true, status_message: "finished formatting")
    UpdateQualityJob.perform_later(@search)
  end
end
