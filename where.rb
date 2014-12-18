class App < Sinatra::Base
  get '/' do
    @people = Person.get_serialized_data
    erb :index
  end

  get '/checkin' do
    erb :'checkin/new'
  end

  post '/checkin' do
    person = Person.first_or_create(:email => params[:email])

    data = {
      message: params[:message],
      timestamp: Time.now
    }

    checkin = person.checkins.new(data)

    if checkin.save
      if request.xhr?
        {
          lat: checkin.lat,
          lng: checkin.lng
        }.to_json
      else
        redirect '/'
      end
    end
  end

  get '/people' do
    @people = Person.all

    erb :'people/index'
  end

  get '/people/:id' do
    @person = Person.get(params[:id])

    erb :'people/show'
  end
end
