class Checkin
  include DataMapper::Resource

  property :id, Serial
  property :message, String
  property :timestamp, DateTime
  property :lat, Float
  property :lng, Float
  belongs_to :person

  before :save, :set_geo_name

  def set_geo_name
    params = {
      username: ENV['GEO_USERNAME'],
      password: ENV['GEO_PASSWORD'],
      type: 'json',
      maxRows: '1',
      q: message
    }

    response = HTTParty.get("http://api.geonames.org/searchJSON", query: params)
    json = JSON.parse(response.body)
    location = json['geonames'].first

    if location
      self.lat = location['lat']
      self.lng = location['lng']
    end
  end

  def self.get_current_checkins
    # this should be replaced with a proper
    # manual sql statement, but is hacked
    # for now so that I can do more fun things
    # with my free time
    return Person.all.map do |person|
      person.checkins.last
    end
  end
end
