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


end #end class

def work_params
  return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
end
