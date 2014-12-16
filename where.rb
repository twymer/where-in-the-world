class App < Sinatra::Base
  get '/' do
    @checkins = Checkin.all
    erb :'index.html'
  end

  get '/checkin' do
    erb :'checkin/new.html'
  end

  post '/checkin' do
    person = Person.first_or_create(:email => params[:email])

    data = {
      message: params[:message],
      timestamp: Time.now
    }

    checkin = person.checkins.new(data)

    if checkin.save
      redirect '/'
    end
  end
end
