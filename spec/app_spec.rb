require 'spec_helper'
require 'factory_girl'
require 'json'

describe "GET /" do
  it "should redirect to /tasks" do
    get "/tasks"
    @tasks_response = last_response
    
    get "/"
    last_response.should be_redirect
    
    follow_redirect!
    last_response.body.should == @tasks_response.body
  end
end

