require 'sinatra'
require 'pry'
require 'pg'

require_relative 'models/content'
require_relative 'models/urls'

use Rack::Session::Cookie, {
  secret: "keep_it_secret_keep_it_safe"
}

def db_connection
  begin
    connection = PG.connect(dbname: "launch_git")
    yield(connection)
  ensure
    connection.close
  end
end

get '/' do
  redirect '/launchg'
end

get '/launchg' do
  @list = Content.all
  erb :index
end

post '/launchg' do
  user = params[:user_name]
  session[:user_name] = params[:user_name]
  db_connection do |conn|
    conn.exec_params("INSERT INTO users(name) VALUES($1)", [user])
  end
  redirect '/'
end

get '/launchg/:user_name' do
  @user = Content.find(params[:user_name])
  @urls = Content.urls(params[:user_name])
  erb :show, locals: { user_name: session[:user_name] }
end

get '/launchg/:user_name/git' do
  Urls.git(params[:user_name])
  redirect '/launchg/:user_name'
end
