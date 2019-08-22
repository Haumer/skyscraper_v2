require 'rails_helper'

RSpec.describe User, type: :model do
  context 'on creation' do
    it 'should have zero searches' do
      should have_many(:searches)
      expect(User.create.searches.length).to eq(0)
    end
    it 'should not be an admin' do
      expect(User.create.admin).to eq(false)
    end
  end
end
