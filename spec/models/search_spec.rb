require 'rails_helper'

RSpec.describe Search, type: :model do
  context 'on creation' do
    search = Search.new
    it 'should not pass validation if no args given' do
      search.valid?
      expect validate_presence_of(:keyword)
      expect(search.errors[:keyword]).to include("can't be blank")
      expect validate_presence_of(:location)
      expect(search.errors[:location]).to include("can't be blank")
    end
    it 'should have zero jobs associated' do
      expect(search).to have_many(:jobs)
      expect(search.jobs.length).to eq(0)
    end
  end

  context 'jobs association' do
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
      expect(search.reload.jobs.length).to eq(1)
    end
  end

  context 'user association' do
    user = User.first
    search = Search.create!(
      user: user,
      location: "testlocation",
      keyword: "testkeyword"
    )
    it 'should belong_to user' do
      expect(search).to belong_to(:user)
      expect(search.reload.user).to eq(user)
    end
  end
end
