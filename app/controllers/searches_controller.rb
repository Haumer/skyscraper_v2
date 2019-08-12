class SearchesController < ApplicationController
  include ActionController::Live
  def new
    @search = Search.new
    @user = current_user
  end

  def index
    @search = Search.all
  end

  def create
    @search = Search.new(user: current_user, keyword: search_params[:keyword])
    @search.user = current_user
    @search.location = "london"
    if @search.save
      ScrapeAllJob.perform_later(@search)
      redirect_to @search
    else
      render :new
    end
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
