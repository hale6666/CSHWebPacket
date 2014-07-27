class SessionsController < ApplicationController
  def new
    if upperclassman_signed_in?
      redirect_to root_url
    end
  end

  def create
    freshman = Freshman.find_by_name(params[:name])
    if freshman and freshman.authenticate(params[:password])
      session[:current_freshman_id] = freshman.id
      redirect_to freshman_path(freshman.id)
    else
      flash[:notice] = "Invalid username/password"
      redirect_to :back
    end
  end

  def destroy
    session.delete(:current_freshman_id)
    redirect_to root_url
  end
end