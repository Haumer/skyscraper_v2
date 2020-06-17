class FormattingJob < ApplicationJob
  queue_as :default
  after_perform :update_status_formatted

  def perform(id)
    @search = Search.find(id)
    @search.jobs.each do |job|
      job.update(title: job.title.gsub(/\s+/, " "))
      job.update(location: job.location.gsub(/\s+/, " "))
      job.update(description: job.location.gsub(/\s+/, " "))
      if job.company[0..(job.company.length/2 - 1)] == job.company[job.company.length/2..-1]
        job.company = job.company[0..job.company.length/2 - 1]
      end
      if job.salary.gsub(/Â/,"").scan(/\d/).length < 4
        job.salary = "unspecified"
      else
        job.update!(salary: job.salary.gsub(/Â/,"").scan(/£?(\d+k|\d+\.\d+|\d+|\d+,\d+|\d+)( - | to |\s-\s)?£?(\d+k|\d+\.\d+|\d+,\d+|\d+)?/).join.gsub("to", "-").gsub("k", "000").gsub(",", "").gsub(".00",""))
      end

      if job.salary.match(/(\d+)\s?-\s?(\d+)/)
        salaries = job.salary.split("-").map { |string| string.scan(/\d/).join.to_i }
        if salaries[0] < salaries[1]
          job.lower_salary = salaries[0].to_i
          job.upper_salary = salaries[1].to_i
        else
          job.lower_salary = salaries[0].to_i
          job.upper_salary = salaries[1].to_i
        end
        job.save
      end
    end
  end

  # TODO: change update into one db call
  private

  def update_status_formatted
    @search.update(status_scraped: true, status_message: "finished formatting")
    UpdateQualityJob.perform_later(@search.id)
  end
end
