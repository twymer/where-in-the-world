class Person
  include DataMapper::Resource

  property :id, Serial
  property :email, String
  property :title, String
  has n, :checkins

  def icon_url(size=nil)
    size = size || 30
    md5 = Digest::MD5.hexdigest(self.email)
    "http://www.gravatar.com/avatar/#{md5}?s=#{size}"
  end

  def self.get_serialized_data
    # Convert all users to a json dict with their
    # email as the key, and their info and checkin data
    # as the value
    people = {}
    Person.all.each do |person|
      people[person.email] = {
        icon_url: person.icon_url,
        total_checkins: person.checkins.count,
        lat: person.checkins.last.lat,
        lng: person.checkins.last.lng,
        message: person.checkins.last.message,
        timestamp: person.checkins.last.timestamp,
      }
    end
    people.to_json
  end
end
