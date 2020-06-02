class SearchesController < ApplicationController
  before_action :set_search, only: [ :show ]

  def index
    @searches = policy_scope(Search)
  end

  def new
    @search = Search.new
    authorize @search
  end

  def create
    @search = Search.new(search_params)
    @search.user = current_user
    @search.location = "london"
    authorize @search
    if @search.save
      ScrapeAllJob.perform_later(@search.id)
      redirect_to @search
    else
      flash.now[:error] = "Please enter a keyword!"
      render :new
    end
  end

  def show
    @jobs = @search.jobs - @search.low_jobs
  end

  private

  def set_search
    @search = Search.find(params[:id])
    authorize @search
  end

  def search_params
    params.require(:search).permit(:keyword, :location)
  end
end
