class User < ActiveRecord::Base
  validates :name, presence: true,
                   length: { minimum: 2, message: 'No way your name is that short.' },
                   uniqueness: true
  has_many :songs, dependent: :destroy
end