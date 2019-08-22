require 'rails_helper'

RSpec.describe Search, type: :model do
  context 'on creation' do
    search = Search.new
    it 'should pass validation' do
      search.valid?
      expect(search.errors[:keyword]).to include("can't be blank")
      expect(search.errors[:location]).to include("can't be blank")
    end
    it 'should have zero jobs associated' do
      should have_many(:jobs)
      expect(search.jobs.length).to eq(0)
    end
  end

  context 'general' do
    search = Search.create!(
      user: User.create(
        password: "123456",
        email: "test@test.test",
        admin: true
      ),
      location: "testlocation",
      keyword: "testkeyword"
    )
    job = Job.create!(
      website: Website.create(
        name: "Test.website",
        base_url: "https.test.url"
      ),
      title: "testtitle",
      salary: "1000",
      location: "testlocation",
      link: "testlink",
      job_website: "testjobwebsite",
      search: search
    )
    it 'should have the correct number of jobs' do
      expect(search.jobs.length).to eq(1)
    end
  end
end
