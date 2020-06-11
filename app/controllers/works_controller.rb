class WorksController < ApplicationController
  before_action :find_work, only: [:show, :edit, :update, :destroy]
  #GET /works
  def index
    # Albums
    @work_albums = Work.where('works.category = ?', 'album')
    @work_albums = @work_albums.sort_by{ |work| work.get_vote_count }.reverse
    @work_movies = Work.where('works.category = ?', 'movie')
    @work_movies = @work_movies.sort_by{ |work| work.get_vote_count }.reverse
    @work_books = Work.where('works.category = ?', 'book')
    @work_books = @work_books.sort_by{ |work| work.get_vote_count }.reverse
    #@works = Work.where(category: 'album') #same
  end

  #GET /works/:id
  def show
    # @work = Work.find_by(id: params[:id])
    # flash[:success] = "#{@work.category} added successfully"
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
    # @work = Work.find_by(id: params[:id])
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
      errors = @work.errors.full_messages.join(', ')
      flash[:error] = errors
      render :new
      return
    end
  end

  #PATCH /works/:id (params)
  def update
    # @work = Work.find_by(id: params[:id])
    if @work.nil?
      head :not_found
      return
    elsif @work.update(work_params)
      flash[:success] = "Successfully updated."
      redirect_to work_path
      return
    else
      render :edit
      return
    end
  end

  #DELETE /works/:id
  def destroy
    # @work = Work.find_by(id: params[:id])
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


private

def work_params
  return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
end

#controller filter
def find_work
  @work = Work.find_by(id: params[:id])
end