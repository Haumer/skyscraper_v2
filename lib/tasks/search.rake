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
  task :errors, [:scraper, :number] => :environment do |t, args|
    if args.key?(:scraper) && !args[:scraper].empty?
      website = Website.find_by_name(args[:scraper])
      if website.nil?
        puts "No website by this name: '#{args[:scraper]}'"
        puts "available websites are:"
        Website.list
      else
        if args.key?(:number)
          ap ScraperError.one(website).first(args[:number])
        else
          ap ScraperError.one(website).first(50)
        end
      end
    else
      if args.key?(:number)
        p args[:number]
        ap ScraperError.general.first(args[:number])
      else
        ap ScraperError.general.first(50)
      end
    end
  end
end
