class Downvote < ActiveRecord::Base
  belongs_to :user
  belongs_to :song
  validates_uniqueness_of :song_id, scope: :user_id

  # def is_unique_vote
  #   duplicate_vote = Downvote.where(song_id: self.song_id, user_id: self.user_id)
  #   false if duplicate_vote
  # end
end