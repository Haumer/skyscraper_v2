class JobsController < ApplicationController
  def index
    @jobs = Jobs.all
  end
end
