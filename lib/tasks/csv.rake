require 'csv'
namespace :csv do
  desc "Extract all jobs from a user to csv"
  task :user, [:id] => :environment do |t, args|
    user = User.find(args[:id].to_i)

    csv_options = { col_sep: ',', force_quotes: true, quote_char: '"' }
    filepath    = 'csvs/jobs.csv'

    CSV.open(filepath, 'wb', csv_options) do |csv|
      csv << user.jobs.first.attributes.keys
      user.jobs.each do |job|
        csv << job.attributes.values
      end
    end
  end

  desc "websites"
  task :websites do
    csv_options = { col_sep: ',', force_quotes: true, quote_char: '"' }
    filepath    = 'csvs/websites.csv'

    CSV.open(filepath, 'wb', csv_options) do |csv|
      csv << Website.first.attributes.keys
      Website.all.each do |website|
        csv << website.attributes.values
      end
    end
  end
end
