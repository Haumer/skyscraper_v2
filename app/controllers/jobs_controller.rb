class JobsController < ApplicationController
  def index
    @jobs = policy_scope(Job)
  end
end
