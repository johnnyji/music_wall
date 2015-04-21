class Upvote < ActiveRecord::Base
  belongs_to :user
  belongs_to :song
  validates_uniqueness_of :song_id, scope: :user_id

  # def is_unique_vote
  #   binding.pry
  #   duplicate_upvote = Upvote.where(song_id: self.song_id, user_id: self.user_id).first
  #   duplicate_upvote.nil? #WHY IS THIS STILL RENDERING AS VALID EVEN THOUGH IT RETURNS FALSE
  # end
end