require 'rails_helper'

RSpec.describe Job, type: :model do
  context 'on creation' do
    job = Job.new
    it 'should not pass validation if no args given' do
      job.valid?
      expect validate_presence_of(:title)
      expect(job.errors[:title]).to include("can't be blank")
      expect validate_presence_of(:location)
      expect(job.errors[:location]).to include("can't be blank")
      expect validate_presence_of(:salary)
      expect(job.errors[:salary]).to include("can't be blank")
      expect validate_presence_of(:link)
      expect(job.errors[:link]).to include("can't be blank")
      expect validate_presence_of(:job_website)
      expect(job.errors[:job_website]).to include("can't be blank")
      expect validate_presence_of(:website)
      expect(job.errors[:website]).to include("must exist")
      expect validate_presence_of(:search)
      expect(job.errors[:search]).to include("must exist")
      expect validate_presence_of(:quality)
      expect(job.quality).to eq(-1)
    end
  end
  context 'website association' do
    job = Job.new
    it 'should belong_to website' do
      expect(job).to belong_to(:website)
    end
  end

  context 'search association' do
    job = Job.new
    it 'should belong_to search' do
      expect(job).to belong_to(:search)
    end
  end
end
