class User < ActiveRecord::Base
  has_many :upvotes
  has_many :downvotes
  has_many :reviews
  
  validates :name, presence: true,
                   length: { minimum: 2, message: 'No way your name is that short.' },
                   uniqueness: true
  has_many :songs, dependent: :destroy
end