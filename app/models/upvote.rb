class Upvote < ActiveRecord::Base
  belongs_to :user
  belongs_to :song
  validates_uniqueness_of :song_id, scope: :user_id
  after_save :destroy_existing_downvote

  def destroy_existing_downvote
    downvote = Downvote.where(user_id: self.user_id, song_id: self.song_id).first
    downvote.destroy unless downvote.nil?
  end
end