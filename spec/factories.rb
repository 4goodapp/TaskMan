require 'factory_girl'
require 'lorem'

FactoryGirl.define do
  sequence :title do |n|
    "Task title \##{n}"
  end

  factory :user do
    username %w[RR IZ AL PN VL VT].sample
  end
  
  factory :task do
    title
    description Lorem::Base.new('words', 15).output
    start_at Time.now
    end_at Time.now
    complete false
    association :user
  end

end