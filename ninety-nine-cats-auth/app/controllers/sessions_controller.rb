class SessionsController < ApplicationController
  before_action :user_logged_in, only: [:new]

  def new
    render :new
  end

  def create
    @user = User.find_by_credentials(
      params[:user][:username],
      params[:user][:password]
      )
    if @user.nil?
      flash[:errors] = @user.errors.full_messages
      redirect_to new_session_url
    else
      @user.reset_session_token!
      login(@user)
      redirect_to cats_url
    end
  end

  def destroy
    current_user.reset_session_token! if current_user
    session[:session_token] = nil
    redirect_to cats_url
  end

end
