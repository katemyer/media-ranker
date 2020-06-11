class UsersController < ApplicationController
  before_action :find_user, only: [:show, :edit, :update, :destroy]
#GET /users
def index
  #check if logged in 
    if session[:user_id] != nil
      @users = User.all
    else
      flash[:error] = "You must be logged in to see all users."
      # redirect_to root_path
      @users = []
    end
end

#GET /users/:id
def show
  if @user.nil?
    head :not_found
    return
  end
  #query DB to get user votes
  @user_votes = Vote.where('user_id = ?', @user.id  )
end

def new
  @user = User.new
end

def edit 
  if @user.nil?
    redirect_to root_path
    return
  end
end

#POST /users (params)
def create
  @user = User.new(user_params)
  if @user.save
    redirect_to user_path(@user.id)
    return
  else
    render :new
    return
  end
end

#PATCH /users/:id (params)
def update
  if @user.nil?
    head :not_found
    return
  elsif @user.update(user_params)
    
    redirect_to user_path
    return
  else
    render :edit
    return
  end
end

#DELETE /users/:id
def destroy
  if @user.nil?
    head :not_found
    return
  end
  
  @user.destroy
  
  redirect_to users_path
  return
end

#GET /login
def login_form
  @user = User.new
end

#POST /login params
def login
  username = params[:user][:username]
  user = User.find_by(username: username)
  if user
    session[:user_id] = user.id
    session[:user_username] = user.username
    flash[:success] = "Successfully logged in as returning user #{username}"
  else
    user = User.create(username: username)
    session[:user_id] = user.id
    session[:user_username] = user.username
    flash[:success] = "Successfully logged in as new user #{username}"
  end

  redirect_to root_path
  return
end

#get /users/current
def current
  @current_user = User.find_by(id: session[:user_id])
  unless @current_user
    flash[:error] = "You must be logged in to see this page"
    redirect_to root_path
    return
  end
end

#post "/logout"
def logout
  session[:user_id] = nil
  session[:user_username] = nil
  redirect_to root_path
  return
end

end #end class


private

def user_params
  return params.require(:user).permit(:username)
end

#controller filter
def find_user
  @user = User.find_by(id: params[:id])
end