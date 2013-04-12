require 'rspec/core'
require 'rspec/core/rake_task'
require 'sinatra/activerecord/rake'
require_relative 'app/app'


task :default => :spec

task :console, :environment do |t, args|
    ENV['RACK_ENV'] = args[:environment] || 'development'
    exec "irb -r irb/completion -r ./app/app -r ./spec/factories"
end

# MATE "rackup -p port" TASK
# task :srv do |t, args|
#   exec "rackup -p "

desc "Run all specs in spec directory (excluding plugin specs)"
RSpec::Core::RakeTask.new(:spec)
