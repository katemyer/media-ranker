require "test_helper"

describe User do
  before do
    @korona = users(:korona)
    @charlie = users(:charlie)
    @gunit = users(:gunit)
    @captain = works(:captain)
    @it = works(:it)
  end
  
  describe "validations" do
    it "is valid when username is present" do
      valid_user = User.new(username: "steve")
      expect(valid_user.valid?).must_equal true
    end
    
    it "is invalid without a user" do
      @gunit.username = nil
      @gunit.save
      expect(@gunit.valid?).must_equal false
      expect(@gunit.errors.messages).must_include :username
      expect(@gunit.errors.messages[:username]).must_equal ["can't be blank"]
    end

  end
  
  describe "relations" do
    it "can have many votes" do
      @new_user = User.create(username: "timberlake")
      Vote.create!(work_id: @captain.id, user_id: @new_user.id)
      Vote.create!(work_id: @it.id, user_id: @new_user.id)
      expect(@new_user.votes.count).must_equal 2
      
      @new_user.votes.each do |vote|
        expect(vote).must_be_instance_of Vote
      end
    end
    
    it "can have many works through votes" do
      @new_user = User.create(username: "timberlake")
      Vote.create!(work_id: @captain.id, user_id: @new_user.id)
      Vote.create!(work_id: @it.id, user_id: @new_user.id)
      
      @new_user.votes.each do |vote|
        voted_work = Work.find_by(id: vote.work_id)
        expect(voted_work).must_be_instance_of Work
      end
    end
  end
end
