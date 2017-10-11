require File.expand_path('../config/application', __FILE__)

Rails.application.load_tasks

if Rails.env.test? || Rails.env.development?
  require 'rubocop/rake_task'
  RuboCop::RakeTask.new

  task default: %i[spec rubocop]
end
