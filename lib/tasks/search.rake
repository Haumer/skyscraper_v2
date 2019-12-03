namespace :search do
  desc "Search all websites for a job"
  task :general, [:job] => :environment do |t, args|
    search = Search.create!(keyword: "#{args[:job]}", location: "london", user: User.where(email: "alexander.haumer@me.com").first)
    ScrapeAllJob.perform_later(search.id)
  end

  desc "Check website scraping has been successful"
  task :latest do
    Scraper.most_recent
  end

  desc "Check errors for one/all scraper(s)"
  task :errors, [:scraper] => :environment do |t, args|
    if args.key?(:scraper)
      website = Website.find_by_name(args[:scraper])
      if website.nil?
        puts "No website by this name: '#{args[:scraper]}'"
        puts "available websites are:"
        Website.list
      else
        ap ScraperError.one(website)
      end
    else
      ap ScraperError.general
    end
  end
end
