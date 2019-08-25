require 'rails_helper'

RSpec.describe Scraper, type: :model do
  context 'on creation' do
    scraper = Scraper.create

    it 'should not pass validation if no args given' do
      scraper.valid?
      expect validate_presence_of(:scrape_url)
      expect(scraper.errors[:scrape_url]).to include("can't be blank")
      expect validate_presence_of(:nr_pages)
      expect(scraper.errors[:nr_pages]).to include("can't be blank")
    end
  end
end
