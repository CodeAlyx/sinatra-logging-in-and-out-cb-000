require_relative '../../config/environment'
class ApplicationController < Sinatra::Base
  configure do
    set :views, Proc.new { File.join(root, "../views/") }
    enable :sessions unless test?
    set :session_secret, "secret"
  end

  get '/' do
    erb :index
  end

  post '/login' do
    if User.find_by(username: params[:username], password: params[:password])
      session[:user_id] = User.find_by(username: params[:username], password: params[:password]).id
    end
    redirect to '/account'
  end

  get '/account' do
    erb :account
  end

  get '/logout' do
    session.clear
    redirect to '/'
  end


end
