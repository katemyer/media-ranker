require "test_helper"

describe Work do
  before do
    @work = Work.new(title: "Jurassic Park")
    @valid_work = Work.new(category: "movie",title: "Jurassic Park",creator: "Steven Spielberg",publication_year: "1988",description: "Life finds a way.")
    @korona = users(:korona)
    @charlie = users(:charlie)
    @gunit = users(:gunit)
  end
  
  describe "validations" do
    it "is valid when parameters are present" do
      # work = {
      #   category: "movie",
      #   title: "Jurassic Park",
      #   creator: "Steven Spielberg",
      #   publication_year: "1988",
      #   description: "Life finds a way."
      # }
      expect(@valid_work.valid?).must_equal true
    end
    
    it "is invalid without a title" do
      invalid_work = works(:jurassic)
      invalid_work.title = nil
      invalid_work.save
      expect(invalid_work.valid?).must_equal false
      expect(invalid_work.errors.messages).must_include :title
      expect(invalid_work.errors.messages[:title]).must_equal ["can't be blank"]
    end

  end
  
  describe "relations" do
    it "can have many votes" do
      @valid_work.save!
      Vote.create!(work_id: @valid_work.id, user_id: @gunit.id)
      Vote.create!(work_id: @valid_work.id, user_id: @korona.id)
      expect(@valid_work.votes.count).must_equal 2
      
      expect {
        Vote.create!(work_id: @valid_work.id, user_id: @charlie.id)
      }.must_differ "@valid_work.votes.count", 1
      
      @valid_work.votes.each do |vote|
        expect(vote).must_be_instance_of Vote
      end
    end
    
    it "can have many users through votes" do
      @valid_work.save!
      Vote.create!(work_id: @valid_work.id, user_id: @gunit.id)
      Vote.create!(work_id: @valid_work.id, user_id: @korona.id)
      
      @valid_work.votes.each do |vote|
        voted_user = User.find_by(id: vote.user_id)
        expect(voted_user).must_be_instance_of User
      end
    end
    
    it "is associated with votes and user so in case a user is destroyed the vote count will decrease" do
      @valid_work.save!
      Vote.create!(work_id: @valid_work.id, user_id: @gunit.id)
      Vote.create!(work_id: @valid_work.id, user_id: @charlie.id)
      expect(@valid_work.votes.count).must_equal 2
      
      expect {
        @gunit.destroy
      }.must_differ "@valid_work.votes.count", -1
    end
  end
   
  describe "custom methods" do
    describe "top_ten" do
      it "returns an array of Works that have the top ten votes in each category" do
        top_movies = Work.topmovies
        expect(top_movies).must_be_instance_of Array
        
        top_movies.each do |work|
          expect(work).must_be_instance_of Work
        end
      end
      
      it "returns the top ten works in descending fashion with the first work to have most votes" do
        # from the fixture setting, max vote is movie Captain America
        top_work = works(:captain)
        top_votes = top_work.votes.count
        expect(Work.topmovies.first).must_equal top_work
        expect(Work.topmovies.first.votes.count).must_equal top_votes
      end
      
      it "returns an array of all works if there are less than 10 works in a category" do
        total_books = Work.where(category: :book).count
        top_books = Work.topbooks
        expect(top_books).must_be_instance_of Array
        expect(top_books.size).must_equal total_books
        
        top_books.each do |work|
          expect(work).must_be_instance_of Work
        end
      end
      
      it "returns an empty array if there are no works in a category" do
        @bone = works(:bone)
        @bone.destroy
        top_albums = Work.topalbums
        expect(top_albums).must_be_instance_of Array
        expect(top_albums.size).must_equal 0
      end
    end
    
    describe "spotlight" do
      it "returns one Work that has the most votes" do
        # from the fixture setting, max vote is movie Captain America
        top_work = works(:captain)
        top_votes = top_work.votes.count
        expect(Work.spotlight).must_be_instance_of Work
        expect(Work.spotlight).must_equal top_work
        expect(Work.spotlight.votes.count).must_equal top_votes
      end
      
      it "returns nil when there are no works in database" do
        Work.destroy_all
        expect(Work.count).must_equal 0
        expect(Work.spotlight).must_be_nil
      end
    end
    
    describe "vote only one time" do
      it "will return false if user has already voted for this work" do
        vote1 = votes(:vote1)
        korona = users(:korona)
        avengers = works(:avengers)
        expect(avengers.is_allowed_to_vote(korona)).must_equal false
      end

      it "will return true if user has already voted for this work" do
        gunit = users(:gunit)
        avengers = works(:avengers)
        expect(avengers.is_allowed_to_vote(gunit)).must_equal true
      end
    end
  end 
end