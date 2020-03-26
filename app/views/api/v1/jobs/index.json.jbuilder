json.array! @jobs do |job|
  json.extract! job, :id, :title, :salary, :company, :location, :job_website, :created_at
end
