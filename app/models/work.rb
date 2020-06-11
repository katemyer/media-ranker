class Work < ApplicationRecord
  #validations
  validates :category, presence: true
  validates :title, presence: true
  validates :creator, presence: true
  validates :publication_year, presence: true
  validates :description, presence: true

  has_many :votes, dependent: :destroy 
  has_many :users, through: :votes

  def get_vote_count
    #filter Vote Db by work_id = this.id
    count = Vote.where(work_id: self.id).count
    return count
  end

  def is_allowed_to_vote(user_id)
    count = Vote.where(work_id: self.id, user_id: user_id).count
    return count == 0
  end

end
