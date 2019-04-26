class UsersController < ApplicationController
  def login_form
    @user = User.new
  end

  def login
    @username = params[:user][:username]
    user = User.find_by(username: @username)
    user = User.create(username: @username) if user.nil?

    if user.id
      session[:user_id] = user.id
      flash[:alert] = "Successfully logged in as #{user.username}"
      redirect_to root_path
    else
      flash[:error] = "Unable to log in"
      redirect_to root_path
    end
  end

  def logout
    user = User.find_by(id: session[:user_id])
    session[:user_id] = nil
    flash[:notice] = "Successfully logged out"
    redirect_to root_path
  end
end
