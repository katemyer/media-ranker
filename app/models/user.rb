class User < ApplicationRecord

  #validations
  validates :username, presence: true

  has_many :votes, dependent: :destroy 
  
  def get_vote_count
    #filter Vote Db by work_id = this.id
    # count = Vote.where(user_id: self.id).count
    count = self.votes.count
    return count
  end

end
