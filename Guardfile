guard :bundler do
  watch 'Gemfile'
end

guard 'coffeescript', input: 'app/assets/javascripts'

guard :rspec, cmd: 'bundle exec rspec' do
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^spec/support/(.+)\.rb$}) { 'spec' }
  watch('spec/spec_helper.rb') { 'spec' }
  watch(%r{^app/(.*)(\.js|\.css|\.scss)$}) { 'spec/features' }
  watch('config/routes.rb') { 'spec/features' }
  watch(%r{^app/helpers/(.*)\.rb$}) { 'spec/features' }
  watch(%r{^app/models/(.*)\.rb$}) { 'spec/features' }
  watch(%r{^app/controllers/(.+)_(controller)\.rb$}) { |m| "spec/features/#{m[1]}_spec.rb" }
  watch('app/controllers/application_controller.rb') { 'spec/features' }
  watch('app/controllers/session_controller.rb') { 'spec/features' }
  watch(%r{^app/views/(.+)/.*\.haml$}) { |m| "spec/features/#{m[1]}_spec.rb" }
  watch(%r{^app/views/(layouts|shared)/.*\.haml$}) { 'spec/features' }
end

guard :rubocop do
  watch(%r{.+\.rb$})
  watch(%r{(?:.+/)?\.rubocop\.yml$}) { |m| File.dirname(m[0]) }
end
