ENV["RACK_ENV"] ||= "development"

require 'sinatra/base'
require_relative 'data_mapper_setup'
require 'sinatra/flash'

class BookmarkManager < Sinatra::Base

enable :sessions
set :session_secret, "super secret"
register Sinatra::Flash

  get '/' do
    redirect '/links'
  end

  get '/users/new' do
    @user = User.new
    erb :'user/new'
  end

  get '/users/sign_in' do
    erb :'user/sign_in'
  end

  post '/users/find' do
    user = User.first(email: params[:email])
    if user
      session[:user_id] = user.id
      redirect '/links'
    else
      flash.now[:errors] = 'Incorrect email or password'
      erb :'user/sign_in'
    end
  end

    post '/users' do
      @user = User.create(email: params[:email],
                         password: params[:password],
                         password_confirmation: params[:password_confirmation])
      if @user.save
        session[:user_id]= @user.id
        redirect '/links'
      else
        flash.now[:errors] = @user.errors.full_messages
        erb :'user/new'
      end
    end

    helpers do
      def current_user
        @current_user ||= User.get(session[:user_id])
      end
    end


  get '/links' do
    @links = Link.all
    erb :'links/index'
  end

  get '/links/new' do
    erb :'links/new'
  end

  post '/links' do
    link = Link.new(url: params[:url],
                    title: params[:title])
    params[:tags].split.each do |tag|
      link.tags << Tag.create(name: tag)
    end
    link.save
    redirect '/links'
  end

  get '/tags/:name' do
    tag = Tag.first(name: params[:name])
    @links = tag ? tag.links : []
    erb :'links/index'
  end

  run! if app_file == $0
end
