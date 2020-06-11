class HomepagesController < ApplicationController

  def index
    @work_spotlight = Work.spotlight
    @work_top_books = Work.topbooks
    @work_top_albums = Work.topalbums
    @work_top_movies = Work.topmovies

  end
end #end class
