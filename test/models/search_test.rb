require 'test_helper'

class SearchTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "Should not save without arguments" do
    search = Search.new
    assert search.invalid?
    assert_not search.save, "Saved without arguments"
  end
end
