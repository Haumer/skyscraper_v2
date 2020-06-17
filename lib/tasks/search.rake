namespace :search do
  desc "Search all websites for a job"
  task :general, [:job] => :environment do |t, args|
    puts "Starting Job scraper"
    search = Search.create!(keyword: "#{args[:job]}", location: "london", user: User.find_by_email("default@skyscraper.com"))
    ScrapeAllJob.perform_now(search.id)
    puts "=> Scraped!"
    puts "Starting Quality check"
    FormattingJob.perform_now(search.id)
    search.report
  end

  desc "Check website scraping has been successful"
  task :latest do
    Scraper.most_recent
  end

  task :preset do
    desc "search for preset keywords"
    keywords = ["software developer", "software engineer", "frontend", "backend", "fullstack", "ruby", "python", "javascript", "node", "react", "angular"]
    puts "searching for:"
    keywords.each do |keyword|
      puts ">#{keyword}. starting."
      search = Search.create!(keyword: keyword, location: "london", user: User.find_by_email("lewagon@skyscraper.com"))
      ScrapeAllJob.perform_now(search.id)
      puts "done."
    end
    puts "search complete!"
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
        ap ScraperError.general.first(args[:number])
      else
        ap ScraperError.general.first(50)
      end
    end
  end
end
