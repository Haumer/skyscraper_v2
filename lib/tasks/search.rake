namespace :search do
  desc "Search all websites for a job"
  task :general, [:job] => :environment do |t, args|
    search = Search.create!(keyword: "#{args[:job]}", location: "london", user: User.where(email: "alexander.haumer@me.com").first)
    ScrapeAllJob.perform_later(search.id)
  end

  desc "Search all websites for a job"
  task :latest do
    Scraper.most_recent
  end
end
