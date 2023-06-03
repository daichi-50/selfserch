class UserSessionsController < ApplicationController
    skip_before_action :require_login , except: [:destroy]
def new; end

def create
    @user = login(params[:email], params[:password])
    if @user
        flash[:success] = "Welcome to the Sample App!"
        redirect_to root_path
    else
        flash.now[:danger] = "Invalid email/password combination"
        render 'new'
    end
end

def destroy
    logout
    flash[:success] = "Logged out"
    redirect_to root_path
end
end
