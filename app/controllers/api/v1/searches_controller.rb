class Api::V1::SearchesController < Api::V1::BaseController
  def index
    @searches = policy_scope(Search)
  end
end
