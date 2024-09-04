require File.expand_path("config/application", __dir__)

Rails.application.load_tasks

if Rails.env.test? || Rails.env.development?
  require "standard/rake"
  Rake::Task[:default].clear
  task default: %i[standard spec]
end
