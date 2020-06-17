class FormattingJob < ApplicationJob
  queue_as :default
  after_perform :update_status_formatted

  def perform(id)
    @search = Search.find(id)
    @search.jobs.each do |job|
      job.title = job.title.gsub(/\s+/, " ")
      job.location = job.location.gsub(/\s+/, " ")
      job.description = job.location.gsub(/\s+/, " ")
      if job.company[0..(job.company.length/2 - 1)] == job.company[job.company.length/2..-1]
        job.company = job.company[0..job.company.length/2 - 1]
      end
      if job.salary.gsub(/Â/,"").scan(/(\d{1,3}[,\.]?\d{0,3})/).flatten.length < 1
        job.update!(salary: "unspecified")
      else
        job.update!(salary: job.salary.scan(/(\d{1,3}[,\.]?\d{0,3})/).join("-"))
      end

      salaries = job.salary.scan(/(\d{1,3}[,\.]?\d{0,3})/).flatten
      unless salaries.length <= 1
        salaries = salaries.flatten.map { |salary| salary.scan(/\d/).join.to_i }
        p salaries
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
