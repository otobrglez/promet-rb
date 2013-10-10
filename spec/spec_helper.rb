require "bundler/setup"

$:.push File.expand_path("../lib", __FILE__)
require 'spork'
require 'promet'


Spork.prefork do
  ENV["APP_ENV"] ||= 'test'
  require "pry"

  RSpec.configure do |config|

    config.filter_run_excluding(no_ci: true) if ENV['CIRCLECI'] == 'true'
    config.filter_run_including(focus: true) unless (ENV['CI'] == 'true') || (ENV['CIRCLECI'] == 'true')

    config.run_all_when_everything_filtered = true
    config.treat_symbols_as_metadata_keys_with_true_values = true

  end
end

Spork.each_run do

end
