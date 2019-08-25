require 'rails_helper'

RSpec.describe Scraper, type: :model do
  before(:each) do
    @scraper = Scraper.new
    @build_scraper = Scraper.last
    @multiple_build_scraper = @build_scraper
    @multiple_build_scraper.update(nr_pages: 3)
  end
  context 'on creation' do
    it 'should not pass validation if no args given' do
      expect(@scraper.valid?).to eq(false)
      expect validate_presence_of(:card_class)
      expect(@scraper.errors[:card_class]).to include("can't be blank")
      expect validate_presence_of(:scrape_url)
      expect(@scraper.errors[:scrape_url]).to include("can't be blank")
      expect validate_presence_of(:title_class)
      expect(@scraper.errors[:title_class]).to include("can't be blank")
      expect validate_presence_of(:link_class)
      expect(@scraper.errors[:link_class]).to include("can't be blank")
      expect validate_presence_of(:location_class)
      expect(@scraper.errors[:location_class]).to include("can't be blank")
      expect validate_presence_of(:company_class)
      expect(@scraper.errors[:company_class]).to include("can't be blank")
      expect validate_presence_of(:salary_class)
      expect(@scraper.errors[:salary_class]).to include("can't be blank")
      expect validate_presence_of(:description_class)
      expect(@scraper.errors[:description_class]).to include("can't be blank")
    end
  end
  context 'website association' do
    it 'should belong_to website' do
      expect(@scraper).to belong_to(:website)
    end
  end

  context 'instance methods' do
    it 'should respond_to #crawl' do
      expect(@scraper).to respond_to(:crawl)
    end
    it 'should respond_to #build_url' do
      expect(@scraper).to respond_to(:build_url)
    end
  end

  context '#build_url' do
    it 'should build the correct url(s)' do
      expected = [
        "https://www.test.com/jobs?q=ruby&l=london&start=0",
        "https://www.test.com/jobs?q=ruby&l=london&start=1",
        "https://www.test.com/jobs?q=ruby&l=london&start=2"
      ]
      expect(@build_scraper.build_url('ruby', 'london').first).to eq(expected.first)
      expect(@multiple_build_scraper.build_url('ruby', 'london')).to eq(expected)
    end
  end

  context '#crawl' do
    it 'should scrape' do
      Scraper.destroy_all
      @crawl_scraper = Scraper.create!(
        card_class: ".result",
        title_class: ".jobtitle",
        link_class: "a",
        location_class: ".location",
        company_class: ".company",
        salary_class: ".no-wrap",
        description_class: ".summary",
        website: Website.where(base_url: "www.indeed.co.uk").first,
        counter_interval: 1,
        counter_start: 0,
        nr_pages: 3,
        scrape_url: "https://www.indeed.co.uk/jobs?q=KEYWORD&l=LOCATION&start=COUNTER"
      )
      Search.destroy_all
      @search = Search.create!(
        user: User.create(
          password: "123456",
          email: "test@test.test",
          admin: true
        ),
        location: "london",
        keyword: "ruby"
      )
      @crawl_scraper.crawl(@search)
      @jobs = @search.jobs
      expect(@jobs.count.zero?).to eq(false)
      expect(@jobs.first.valid?).to eq(true)
      expect(@jobs.first.quality).to eq(-1)
      expect(@jobs.first.title.downcase.include?(@search.keyword)).to eq(true)
    end
  end
end
