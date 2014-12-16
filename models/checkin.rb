class Checkin
  include DataMapper::Resource

  property :id, Serial
  property :message, String
  property :timestamp, DateTime
  property :lat, Float
  property :lng, Float
  belongs_to :person
end
