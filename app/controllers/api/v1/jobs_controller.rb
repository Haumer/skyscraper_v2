class Api::V1::JobsController < Api::V1::BaseController
  def index
    @jobs = policy_scope(Job)
  end
end
