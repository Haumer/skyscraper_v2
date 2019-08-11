class SearchesController < ApplicationController
  include ActionController::Live
  def new
    @search = Search.new
  end

  def index
    @search = Search.all
  end

  def create
    @search = Search.new(user: current_user, keyword: search_params[:keyword])
  end

  def show
    @search = Search.find(params[:id])
    @jobs = @search.jobs
  end

  private

  def search_params
    params.require(:search).permit(:keyword)
  end
end
