require "test_helper"

describe User do
  let (:new_user) {
    User.new(username: "test_user")
  }
  it "can be instantiated" do
    # Assert
    expect(new_user.valid?).must_equal true
  end
  
  it "will have the required fields" do
    # Arrange
    new_user.save
    found_user= User.find(new_user.id)

      # Assert
      expect(found_user.username).must_equal "test_user"
  end
end
