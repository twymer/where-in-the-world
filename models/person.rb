class Person
  include DataMapper::Resource

  property :id, Serial
  property :email, String
  property :title, String
  has n, :checkins
end
