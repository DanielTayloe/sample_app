class SessionsController < ApplicationController
#Manages the current session by using


#Used at Sign in, renders the view 'new' for sessions
def new
end

#Used when clicking Sign in button
def create
  user = User.find_by(email: params[:session][:email].downcase)
  if user && user.authenticate(params[:session][:password])
    sign_in user
    redirect_back_or user
  else
    flash.now[:error] = 'Invalid email/password combination'
    render 'new'
  end
end

#Used when Signing out the current user
def destroy
  sign_out
  redirect_to root_url
end

end
