class HomepagesController < ApplicationController

  def index
    
    #Spotlight
    # Process to get work with most votes
    # https://stackoverflow.com/a/7131200

    # output of query is array that looks like this [1, 3] where 1 is work.id and 3 is the num of votes
    work_spotlight_id = Vote.left_joins(:work)     # Start with Vote left-join with Work
                            .group('works.id')     # Group by works id & Count
                            .order('count_id desc') # Order desc (get vote most first)
                            .count('id') # count the votes by group  (this returns a HASH)
                            .first #this gives me the hash with most votes in an array [1,3] where 1 is the work.id & 3 is the vote count
    if work_spotlight_id.length > 0
      @work_spotlight = Work.find(work_spotlight_id[0])  # 0 element is the work.id of the most votes
    else
      @work_spotlight = []
    end

    # Top 10 Books
    top_book_ids = Vote.left_joins(:work) #Joins Vote <- Work
                        .where('works.category = ?', 'book' ) # filter for only category =
                        .group('works.id') # group by id
                        .order('count_id desc') # sort by count hi to low
                        .count('id') # count by id, this returns a HASH
                        .keys # from hash get only the keys which are work.id s, this returns an array of keys/work.ids
                        .slice(0,10) # get only the first 10 keys/work.ids
    @work_top_books = Work.find(top_book_ids)

    # Top 10 Movies
    top_movie_ids = Vote.left_joins(:work) #Joins Vote <- Work
                        .where('works.category = ?', 'movie' ) # filter for only category =
                        .group('works.id') # group by id
                        .order('count_id desc') # sort by count hi to low
                        .count('id') # count by id, this returns a HASH
                        .keys # from hash get only the keys which are work.id s, this returns an array of keys/work.ids
                        .slice(0,10) # get only the first 10 keys/work.ids
    @work_top_movies = Work.find(top_movie_ids)

    # Top 10 Albums
    top_album_ids = Vote.left_joins(:work) #Joins Vote <- Work
                        .where('works.category = ?', 'album' ) # filter for only category =
                        .group('works.id') # group by id
                        .order('count_id desc') # sort by count hi to low
                        .count('id') # count by id, this returns a HASH
                        .keys # from hash get only the keys which are work.id s, this returns an array of keys/work.ids
                        .slice(0,10) # get only the first 10 keys/work.ids
    @work_top_albums = Work.find(top_album_ids) # get an Array of Work objects from keys we found
  end
end #end class
