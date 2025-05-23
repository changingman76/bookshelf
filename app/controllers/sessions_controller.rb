class SessionsController < ApplicationController
  def login
    # Render the login page
  end

  def create
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_path, notice: "Erfolgreich eingeloggt."
    else
      flash.now[:alert] = "Ungültige E-Mail oder Passwort."
      render :login
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "Abgemeldet."
  end
end 
