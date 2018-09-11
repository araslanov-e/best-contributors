require 'pry'
require 'webmock/rspec'

RSpec.configure do |config|
  Dir[File.dirname(__FILE__) + "/support/**/*.rb"].each do |file|
    require file
  end
end
