class SessionsController < ApplicationController
  def new
  end

  def create
    users = Arel::Table.new(:users)
    user = User.where(
      users[:username].eq(params[:signin][:username]).
      or(users[:email].eq(params[:signin][:username]))
    ).first

    if user && user.authenticate(params[:signin][:password])
      session[:user_id] = user.id
      flash[:notice] = "Signed in successfully."
      redirect_to root_url
    else
      flash[:error] = "Sorry"
      render :new
    end
  end
end
