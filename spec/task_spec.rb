require 'spec_helper'
require 'factory_girl'
require 'json'

def populate_tasks
  if Task.all.empty?
    5.times{ FactoryGirl.build(:task).save }
  end
end

describe 'GET /tasks' do
  populate_tasks
  
  it "should return all tasks in JSON format" do
    @tasks = Task.all
    get '/tasks'
    last_response.should be_ok
    last_response.body.should ==  @tasks.to_json
  end
end
  
describe 'GET /task/:id' do
  populate_tasks
  
  it "should return a task by id in JSON fromat" do
    @task = Task.find(1)
    get '/task/1'
    last_response.body.should == @task.to_json
  end
end
  
describe 'POST /task/create, with params' do
  populate_tasks
  
  it "should create a task from parameters" do
    @task = FactoryGirl.build(:task)
    params = {
      title: @task.title,
      description: @task.description,
      start_at: @task.start_at,
      end_at: @task.end_at,
      complete: @task.complete,
      user_id: @task.user_id
    }
    post '/task/create', params
    last_request.should be_ok
    @last_task = Task.all.last
    @task.id = @last_task.id
    
    @task.should == @last_task
  end
end

describe 'PUT /task/:id/complete' do
  populate_tasks
  
  it "should mark a task as complete" do
    @task = FactoryGirl.build(:task, complete: false)
    @task.save
    put "/task/#{@task.id}/complete"
    get "/task/#{@task.id}"
    @task.complete = true
    last_response.body.should == @task.to_json
  end
end
