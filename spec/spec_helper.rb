# frozen_string_literal: true

require "pry-byebug"

if ENV["COVER"]
  require "simplecov"
  SimpleCov.root File.join(File.dirname(__FILE__), "..")
  SimpleCov.add_filter "/spec/"
  SimpleCov.start
end

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "lite_cable"
require "lite_cable/server"

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

RSpec.configure do |config|
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.include AsyncHelpers, async: true

  config.example_status_persistence_file_path = "tmp/rspec_examples.txt"
  config.filter_run :focus
  config.run_all_when_everything_filtered = true

  config.order = :random
  Kernel.srand config.seed
end
