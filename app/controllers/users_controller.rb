class UsersController < ApplicationController
  before_action :signed_in_user, only: [:index, :edit, :update]
  before_action :correct_user, only: [:edit, :update]

  #Shows all of the users
  def index
    @users = User.all
  end

  #Shows the current user's profile
  def show
  	@user = User.find(params[:id])
  end

  #Used when signing up
  def new
  	@user = User.new
  end

  #Part of: new...when clicking the submit button
  def create
  	@user = User.new(user_params)
  	if @user.save
      sign_in @user
  		flash[:success] = "Welcome to the Sample App!"
  		redirect_to @user
  	else
  		render 'new'
  	end
  end


  def edit
    #The before_action(s) handle accessing the edit and update pages
    #@user = User.find(params[:id])
  end

  def update
    #@user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  private
  def user_params #fixes a mass assignment vulnerability 
    params.require(:user).permit(:name, :email, :password, 
    	:password_confirmation)
  end

  #Before filters
  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_url, notice: "Please sign in."
    end
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end
  
end