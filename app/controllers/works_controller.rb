class WorksController < ApplicationController
  
  #GET /works
  def index
    @works = Work.all
  end

  #GET /works/:id
  def show
    @work = Work.find_by(id: params[:id])
  end

  # def new
  #   @work = Work.new
  # end

  # def edit
  #   @passenger = Passenger.find_by(id: params[:id])
    
  #   if @passenger.nil?
  #     redirect_to root_path
  #     return
  #   end
  # end

  # def create
  #   @passenger = Passenger.new(passenger_params)
  #   if @passenger.save
  #     redirect_to passenger_path(@passenger.id)
  #     return
  #   else
  #     render :new
  #     return
  #   end
  # end

  # def update
  #   @passenger = Passenger.find_by(id: params[:id])
  #   if @passenger.nil?
  #     head :not_found
  #     return
  #   elsif @passenger.update(passenger_params)
      
  #     redirect_to passenger_path
  #     return
  #   else
  #     render :edit
  #     return
  #   end
  # end

  # def destroy
  #   passenger_id = params[:id]
  #   @passenger = Passenger.find_by_id(passenger_id)
    
  #   if @passenger.nil?
  #     head :not_found
  #     return
  #   end
    
  #   @passenger.destroy
    
  #   redirect_to passengers_path
  #   return
  # end


end #end class

def work_params
  return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
end
