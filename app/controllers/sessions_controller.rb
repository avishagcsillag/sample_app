class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)

    if (user && user.authenticate(params[:session][:password]))
      # Log the user in and redirect to the user's show page.
      log_in user
      remember user
      redirect_to user

    elsif user.nil?
      # Create an error message.
      # byebug
      	flash.now[:danger] = 'User email does not exist' # Not quite right!
      	render 'new'
    else
      	flash.now[:danger] = 'Invalid password' # Not quite right!
      	render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end

end
