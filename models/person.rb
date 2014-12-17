class Person
  include DataMapper::Resource

  property :id, Serial
  property :email, String
  property :title, String
  has n, :checkins

  def icon_url
    md5 = Digest::MD5.hexdigest(self.email)
    "http://www.gravatar.com/avatar/#{md5}?s=30"
  end
end
