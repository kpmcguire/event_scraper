class AccessController < ApplicationController
  
  # layout 'admin'
  
  before_action :confirm_logged_in, :except => [:login, :attempt_login, :logout]

  def menu

  end

  def login

  end

  def attempt_login
    if params[:username].present? && params[:password].present?
      found_user = User.where(:username => params[:username]).first
      if found_user
        authorized_user = found_user.authenticate(params[:password])
      end 
    end

    if authorized_user
      session[:user_id] = authorized_user.id
      flash[:notice] = "You are now logged in"
      redirect_to(users_path)
    else
      flash.now[:notice] = "Bad username/password combo"
      render('login')
    end

  end 

  def logout
    session[:user_id] = nil
    flash[:notice] = "you are logged out dude"
    redirect_to access_login_path
  end 

  private


end
