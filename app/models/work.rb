class Work < ApplicationRecord
  #validations
  validates :category, presence: true
  validates :title, presence: true
  validates :creator, presence: true
  validates :publication_year, presence: true
  validates :description, presence: true

  has_many :votes, dependent: :destroy 
  has_many :users, through: :votes

  def get_vote_count
    #filter Vote Db by work_id = this.id
    count = Vote.where(work_id: self.id).count
    return count
  end

  def is_allowed_to_vote(user_id)
    count = Vote.where(work_id: self.id, user_id: user_id).count
    return count == 0
  end

  
 #Spotlight
  def self.spotlight
    # Process to get work with most votes
    # https://stackoverflow.com/a/7131200

    # or this version: Work.all.sort_by {|work| work.votes.count}.reverse.slice(0,10)
    # output of query is array that looks like this [1, 3] where 1 is work.id and 3 is the num of votes
    work_spotlight_id = Vote.left_joins(:work)     # Start with Vote left-join with Work
                            .group('works.id')     # Group by works id & Count
                            .order('count_id desc') # Order desc (get vote most first)
                            .count('id') # count the votes by group  (this returns a HASH)
                            .first #this gives me the hash with most votes in an array [1,3] where 1 is the work.id & 3 is the vote count
    if work_spotlight_id != nil
      work_spotlight = Work.find(work_spotlight_id[0])  # 0 element is the work.id of the most votes
    else
      work_spotlight = nil
    end
    return work_spotlight
  end

    # Top 10 Books
  def self.topbooks
    top_book_ids = Vote.left_joins(:work) #Joins Vote <- Work
                        .where('works.category = ?', 'book' ) # filter for only category =
                        .group('works.id') # group by id
                        .order('count_id desc') # sort by count hi to low
                        .count('id') # count by id, this returns a HASH
                        .keys # from hash get only the keys which are work.id s, this returns an array of keys/work.ids
                        .slice(0,10) # get only the first 10 keys/work.ids
    return work_top_books = Work.find(top_book_ids)
  end

    # Top 10 Movies
  def self.topmovies
    top_movie_ids = Vote.left_joins(:work) #Joins Vote <- Work
                        .where('works.category = ?', 'movie' ) # filter for only category =
                        .group('works.id') # group by id
                        .order('count_id desc') # sort by count hi to low
                        .count('id') # count by id, this returns a HASH
                        .keys # from hash get only the keys which are work.id s, this returns an array of keys/work.ids
                        .slice(0,10) # get only the first 10 keys/work.ids
    return work_top_movies = Work.find(top_movie_ids)
  end

    # Top 10 Albums
  def self.topalbums
    top_album_ids = Vote.left_joins(:work) #Joins Vote <- Work
                        .where('works.category = ?', 'album' ) # filter for only category =
                        .group('works.id') # group by id
                        .order('count_id desc') # sort by count hi to low
                        .count('id') # count by id, this returns a HASH
                        .keys # from hash get only the keys which are work.id s, this returns an array of keys/work.ids
                        .slice(0,10) # get only the first 10 keys/work.ids
    return work_top_albums = Work.find(top_album_ids) # get an Array of Work objects from keys we found
  end
end
