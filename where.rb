class App < Sinatra::Base
  get '/' do
    @checkins = Checkin.all
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
      redirect '/'
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
