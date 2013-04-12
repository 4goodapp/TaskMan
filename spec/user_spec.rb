require 'spec_helper'
require 'factory_girl'
require 'json'

def populate_users
  if User.all.empty?
    5.times{ FactoryGirl.build(:user).save }
  end
end

describe 'GET /users' do
  populate_users
  
  it "should return all users in JSON format" do
    @users = User.all
    get '/users'
    last_response.should be_ok
    last_response.body.should == @users.to_json
  end
end

describe 'GET /user/:id' do
  populate_users
  
  it "should return a user by id in JSON format" do
    @user = User.find(1)
    get '/user/1'
    last_response.body.should == @user.to_json
  end
end

describe 'GET /user/:id/tasks' do
  populate_users
  
  it "should return all tasks of a user" do
    @tasks = User.find(1).tasks
    get '/user/1/tasks'
    last_response.body.should == @tasks.to_json
  end
end

describe 'POST /user/create, with params' do
  populate_users
  
  it "should create a user from parameters" do
    @user = FactoryGirl.build(:user)
    params = {
      username: @user.username
    }
    post '/user/create', params
    last_response.should be_ok
    @last_user = User.all.last
    @user.id = @last_user.id
    
    @user.should == @last_user
  end
end

