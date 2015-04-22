class Downvote < ActiveRecord::Base
  belongs_to :user
  belongs_to :song
  validates_uniqueness_of :song_id, scope: :user_id
  after_save :destroy_existing_upvote

  def destroy_existing_upvote
    upvote = Upvote.where(user_id: self.user_id, song_id: self.song_id).first
    upvote.destroy unless upvote.nil?
  end
end