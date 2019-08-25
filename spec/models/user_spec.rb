require 'rails_helper'

RSpec.describe User, type: :model do
  context 'on creation' do
    no_args_user = User.create
    invalid_user = User.create(password: '', email: 'blah')

    it 'should not pass validation if no args given' do
      no_args_user.valid?
      expect validate_presence_of(:email)
      expect(no_args_user.errors[:email]).to include("can't be blank")
      expect validate_presence_of(:password)
      expect(no_args_user.errors[:password]).to include("can't be blank")
    end

    it 'should not pass validation with incorrect args' do
      invalid_user.valid?
      expect(invalid_user.errors[:email]).to include('is invalid')
      expect(invalid_user.errors[:password]).to include("can't be blank")
    end
    it 'should have zero searches associated' do
      should have_many(:searches)
      expect(User.create.searches.length).to eq(0)
    end
    it 'should not be an admin' do
      expect(User.create.admin).to eq(false)
    end
  end
end
