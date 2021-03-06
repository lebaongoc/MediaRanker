class UsersController < ApplicationController
  before_action :find_user, only: [:current, :logout]

  def login_form
    @user = User.new
  end

  def index
    @users = User.all.order(:created_at)
  end

  def show
    @user = User.find_by(id: params[:id])
    if @user.nil?
      flash[:error] = "Invalid user"
      redirect_to root_path
    end
  end

  def login
    @username = params[:user][:username]
    user = User.find_by(username: @username)
    user = User.create(username: @username) if user.nil?

    if user.id
      session[:user_id] = user.id
      flash[:success] = "Successfully logged in as #{user.username}"
      redirect_to root_path
    else
      flash[:error] = "Unable to log in"
      redirect_to root_path
    end
  end

  def logout
    session[:user_id] = nil
    flash[:notice] = "Successfully logged out"
    redirect_to root_path
  end

  private

  def find_user
    @user = User.find_by(id: session[:user_id])
  end
end
