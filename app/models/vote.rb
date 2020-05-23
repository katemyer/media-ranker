class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :work
end
