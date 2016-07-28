ENV["RACK_ENV"] ||= "development"
require 'sinatra/base'
require_relative 'data_mapper_setup'
require_relative 'models/link'
require 'sinatra/flash'

class BookmarkManager < Sinatra::Base

enable :sessions
set :session_secret, 'super secret'
register Sinatra::Flash

get '/' do
  erb :'links/home'
end

get '/links' do
  @links =Link.all
  @tags = Tag.all
  erb :'links/index'
end

get '/links/new' do
  erb :'links/new'
end

post '/links' do
  link = Link.new(url: params[:url], title: params[:title])
  params[:tag].split.each do |tag|
    link.tags << Tag.create(tag: tag)
  end
  link.save
  redirect '/links'
end

get '/tags' do
  tag = Tag.first(tag: params[:tag])
  @links = tag ? tag.links : []
  erb :'links/index'
end

get '/user/new' do
  @user = User.new
  erb :'user/sign_up'
end

post '/user' do
  @user = User.new(name: params[:name],
                    email: params[:email],
                    password: params[:password],
                    password_confirmation: params[:password_confirmation])
  if @user.save
    session[:user_id] = @user.id
    redirect '/'
  else
    flash.now[:incorrect_password] = "Your passwords don't match"
    erb :'/user/sign_up'
  end
end

helpers do
  def current_user
    @current_user ||= User.get(session[:user_id])
  end
end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
