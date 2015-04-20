class Song < ActiveRecord::Base
  URL_FORMAT_REGEX = /\A(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?\z/ix
  before_validation :format_song_url
  validates_presence_of :title, message: "Your song needs a title"
  validates_presence_of :author, message: "You forgot to put your name"
  validates_format_of :url, { with: URL_FORMAT_REGEX }
  # before_save :capitalize

  def capitalize
    #capitalize all input fields
  end

  def format_song_url
    self.url = "http://#{self.url}" unless self.url =~ /^http/
  end

end