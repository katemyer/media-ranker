class User < ApplicationRecord
  has_many :votes, dependent: :destroy 
end
