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
    if (self.message =~ /^(\-?\d+(\.\d+)?),\s*(\-?\d+(\.\d+)?)$/).nil?
      # if message is not coordinates, we need to look those up from geo data
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
    else
      # if message is coordinates, then we just save those and move along
      self.lat = message.split(',')[0].strip
      self.lng = message.split(',')[1].strip
    end
  end
end
