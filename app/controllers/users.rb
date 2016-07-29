class BookmarkManager < Sinatra::Base


  get 'users/new' do
    @user = User.new
    erb :'user/new'
  end

  post '/users' do
    @user = User.create(email: params[:email],
                        password: params[:password],
                        password_confirmation: params[:password_confirmation])
    if @user.save
      session[:user_id] = @user.id
      redirect '/links'
    else
      flash.now[:errors] = @user.errors.full_messages
      erb :'user/new'
    end
  end

end
