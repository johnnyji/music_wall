class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :song
  
  validates :content, 
            presence: true, length: { minimum: 3 }
  validates_uniqueness_of :song_id, scope: :user_id #makes sure that a user can only post one review per song
end