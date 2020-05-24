require "test_helper"

describe Work do
  let (:new_work) {
    Work.new(category: "album", title: "Let it burn", creator: "Usher", publication_year: "2000", description: "best running album")
  }
  it "can be instantiated" do
    # Assert
    expect(new_work.valid?).must_equal true
  end

  it "will have the required fields" do
    # Arrange
    new_work.save
    work = Work.first
    [:category, :title, :creator, :publication_year, :description].each do |field|

      # Assert
      expect(work).must_respond_to field
    end
  end
end