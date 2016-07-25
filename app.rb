require 'sinatra/base'

class BookingManager < Sinatra::Base
  get '/' do
    'Hello BookingManager!'
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
