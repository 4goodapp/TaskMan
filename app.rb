require 'json'
require_relative 'base'

class App < Sinatra::Base
  set :views, settings.root + '/app/views'

  get '/' do
    erb :layout
  end

  get '/users' do
    @users = User.all
    content_type :json
    @users.to_json
  end
  
  get '/user/:id' do
    @user = User.find(params[:id])
    content_type :json
    @user.to_json
  end
  
  get '/user/:id/tasks' do
    @user = User.find(params[:id])
    content_type :json
    @user.tasks.to_json
  end
  
  post '/user/create' do
    User.new(params).save
  end
  
  get '/tasks' do
    content_type :json
    Task.all.to_json
  end
  
  get '/task/:id' do
    content_type :json
    Task.find(params[:id]).to_json
  end
  
  post '/task/create' do
    Task.new(params).save
  end
  
  put '/task/:id/complete' do
    @task = Task.find(params[:id])
    @task.complete = true
    @task.save
  end

end
