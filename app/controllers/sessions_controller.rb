class SessionsController < ApplicationController

  def new

  end

  def create    
    user = User.find_by(username: params[:username]) 

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:notice] = "You've successfully logged in."
      redirect_to root_path
    else
      flash[:error] = 'User name and/or password are incorrect.'
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "You've successfully logged out."
    redirect_to root_path
  end
end