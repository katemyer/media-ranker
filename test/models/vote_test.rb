require "test_helper"

describe Vote do
  before do
    @charlie = users(:charlie)
    @gunit = users(:gunit)
    @it = works(:it)
    @ant = works(:ant)
    @vote = Vote.new(work_id: @it.id, user_id: @gunit.id)
  end

  describe "validations" do
    it "is valid when the user_id and work_id combination is present" do
      expect(@vote.valid?).must_equal true
    end

    it "is invalid when the work_id is missing" do
      @vote.work_id = nil
      expect(@vote.valid?).must_equal false
      expect(@vote.errors.messages).must_include :work
      expect(@vote.errors.messages[:work]).must_equal ["must exist"]
    end

    it "is invalid when the user_id is missing" do
      @vote.user_id = nil
      expect(@vote.valid?).must_equal false
      expect(@vote.errors.messages).must_include :user
      expect(@vote.errors.messages[:user]).must_equal ["must exist"]
    end
  end 

  describe "relations" do
    it "belongs to one user" do
      @vote.save
      expect(@vote.user).must_be_instance_of User
      expect(@vote.user).must_equal @gunit
    end

    it "belongs to one work" do
      @vote.save
      expect(@vote.work).must_be_instance_of Work
      expect(@vote.work).must_equal @it
    end
  end
end