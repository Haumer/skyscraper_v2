class FormattingJob < ApplicationJob
  queue_as :default
  after_perform :update_status_formatted

  def perform(id)
    @search = Search.find(id)
    @search.jobs.each do |job|
      job = remove_space_chars(job)
      job = remove_duplicate_name(job)
      job = salary_digits(job)
      job = salary_bounds(job)
      job.save
    end
  end

  private

  def remove_space_chars(job)
    job.title = job.title.gsub(/\s+/, " ")
    job.location = job.location.gsub(/\s+/, " ")
    job.description = job.description.gsub(/\s+/, " ")
    job
  end

  def remove_duplicate_name(job)
    double = job.company[0..(job.company.length/2 - 1)] == job.company[job.company.length/2..-1]
    job.company = job.company[0..job.company.length/2 - 1] if double
    job
  end

  def salary_digits(job)
    salary_present = job.salary.scan(/(\d{1,3}[,\.]?\d{0,3})/).flatten.length > 1
    job.salary = salary_present ? job.salary.scan(/(\d{1,3}[,\.]?\d{0,3})/).join("-") : "unspecified"
    job
  end

  def salary_bounds(job)
    salaries = job.salary.scan(/(\d{1,3}[,\.]?\d{0,3})/).flatten
    unless salaries.length <= 1
      salaries = salaries.flatten.map { |salary| salary.scan(/\d/).join.to_i }
      if salaries[0] < salaries[1]
        job.lower_salary = salaries[0].to_i
        job.upper_salary = salaries[1].to_i
      else
        job.lower_salary = salaries[0].to_i
        job.upper_salary = salaries[1].to_i
      end
    end
    job
  end

  def update_status_formatted
    @search.update(status_scraped: true, status_message: "finished formatting")
    UpdateQualityJob.perform_later(@search.id)
  end
end
