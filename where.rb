require 'sinatra'

module WhereInTheWorld
  class App < Sinatra::Base
    get '/' do
      erb :'index.html'
    end
  end
end
