class SessionsController < ApplicationController
layout "we"
def new
  session[:"to_url"]= request.referer
end

def create
  user = User.authenticate(params[:email], params[:password])
  if user
    session[:user_id] = user.id
    redirect_to (session[:"to_url"].nil?) ?  root_url : session[:"to_url"].to_s , :notice => "Logged in!"
    #redirect_to root_url, :notice => "Logged in!"
  else
    flash.now.alert = "Invalid email or password"
    render "new"
  end
end

def destroy
  session[:user_id] = nil
  redirect_to root_url, :notice => "Logged out!"
end

end
