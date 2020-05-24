require "test_helper"

describe VotesController do
  it "can get the Votes index" do
    get votes_path

    must_respond_with :success
  end
end
