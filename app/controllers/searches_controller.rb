class SearchesController < ApplicationController

  def new
    @search = Search.new
  end

  def create
    @search = Search.new(user: current_user, keyword: search_params[:keyword])
  end

  private

  def search_params
    params.require(:search).permit(:keyword)
  end
end
