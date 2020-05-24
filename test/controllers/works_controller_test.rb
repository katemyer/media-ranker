require "test_helper"

describe WorksController do
  it "can get the Works index" do
    get works_path

    must_respond_with :success
  end
end
