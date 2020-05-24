require "test_helper"

describe UsersController do
  it "can get the Users index" do
    get users_path

    must_respond_with :redirect
  end
end
