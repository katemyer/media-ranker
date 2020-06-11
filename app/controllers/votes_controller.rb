class VotesController < ApplicationController
#GET /votes
def index
  @votes = Vote.all
end

#GET /votes/:id
def show
  @vote = Vote.find_by(id: params[:id])
  flash[:success] = "Vote added successfully"
  if @vote.nil?
    flash.now[:error] = "Something happened. Vote not added."
    render :new, status: :bad_request
    #head :not_found
    return
  end
end

def new
  @vote = Vote.new
end

#POST /votes (params)
def create
  @vote = Vote.new(vote_params)
  if @vote.save
    redirect_to vote_path(@vote.id)
    return
  else
    render :new
    return
  end
end

#PATCH /votes/:id (params)
def update
  @vote = Vote.find_by(id: params[:id])
  if @vote.nil?
    head :not_found
    return
  elsif @vote.update(vote_params)
    
    redirect_to vote_path
    return
  else
    render :edit
    return
  end
end

#DELETE /votes/:id
def destroy
  @vote = Vote.find_by(id: params[:id])
  if @vote.nil?
    head :not_found
    return
  end
  
  @vote.destroy
  
  redirect_to votes_path
  return
end


end #end class

def vote_params
return params.require(:vote).permit(:work_id, :user_id)
end

