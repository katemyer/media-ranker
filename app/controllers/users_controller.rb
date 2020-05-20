class UsersController < ApplicationController
  #GET /users
  def index
    @users = User.all
  end

  #GET /users/:id
  def show
    user_id = params[:id]
    @User = User.find_by(id: user_id)

    if @user.nil?
      head :not_found
      return
    end
  end

end #end UsersController 
