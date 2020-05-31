class UsersController < ApplicationController
  before_action :set_user, only: [ :show, :update ]

  def show
  end

  def update
    if @user.update(user_params)
      redirect_to @user
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
    authorize @user
  end

  def user_params
    params.require(:user).permit(:api_access, :github_username)
  end
end
