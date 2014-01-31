class SessionsController < ApplicationController

  def new

  end

  def create    
    user = User.find_by(username: params[:username]) 

    if user && user.authenticate(params[:password])
      if user.two_factor_auth?
        session[:two_factor] = true
        user.generate_pin
        user.send_pin_to_twilio
        redirect_to pin_path
      else
        login_user(user)
      end 
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

  def pin
    access_denied if session[:two_factor].nil?

    if request.post?
      user = User.find_by(pin: param[:pin])
      if user
        session[:two_factor] = nil
        user.remove_pin
        login_user user
      else
        flash[:error] = "Something is wrong with your pin number."
        redirect_to pin_path
      end
    end
  end

  private

  def login_user user
    session[:user_id] = user.id
    flash[:notice] = "You've successfully logged in."
    redirect_to root_path   
  end
end