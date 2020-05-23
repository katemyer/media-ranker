class WorksController < ApplicationController
  
  #GET /works
  def index
    @works = Work.all
  end

  #GET /works/:id
  def show
    @work = Work.find_by(id: params[:id])
    flash[:success] = "Book added successfully"
    if @work.nil?
      flash.now[:error] = "Something happened. Book not added."
      render :new, status: :bad_request
      #head :not_found
      return
    end
  end

  def new
    @work = Work.new
  end

  def edit
    @work = Work.find_by(id: params[:id])
    
    if @work.nil?
      redirect_to root_path
      return
    end
  end

  #POST /works (params)
  def create
    @work = Work.new(work_params)
    if @work.save
      redirect_to work_path(@work.id)
      return
    else
      render :new
      return
    end
  end

  #PATCH /works/:id (params)
  def update
    @work = Work.find_by(id: params[:id])
    if @work.nil?
      head :not_found
      return
    elsif @work.update(work_params)
      
      redirect_to work_path
      return
    else
      render :edit
      return
    end
  end

  #DELETE /works/:id
  def destroy
    @work = Work.find_by(id: params[:id])
    if @work.nil?
      head :not_found
      return
    end
    
    @work.destroy
    
    redirect_to works_path
    return
  end
  
  #post "/works/:id/upvote"
  def upvote
    # get work_id from params
    work_id = params[:id]

    # get user_id
    user_id = session[:user_id]

    if user_id != nil
      # get Work from the id
      work = Work.find_by(id: work_id)
      
      # if exists
      if work != nil
        # create vote
        if work.is_allowed_to_vote(user_id)
          vote = Vote.new(user_id: user_id, work_id: work_id)
          if vote.save
            # route to /works
            redirect_to works_path
            return
          else
            flash[:error] = "Error Vote failed to save"
            redirect_to works_path
            return
          end #vote.save
        else
          flash[:error] = "Error User Already Voted!"
          redirect_to works_path
          return
        end
      else
        flash[:error] = "Error Work not found"
        redirect_to works_path
        return
      end #work != nil
    else
      flash[:error] = "Error Must Be Logged In to vote"
      redirect_to works_path
      return
    end  #user !- nill
  end #method upvote

end #end class

def work_params
  return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
end
