# require "codeclimate-test-reporter"
# CodeClimate::TestReporter.start
require 'rspec/its'
require 'pry'
require 'huia'

if defined? Turnip
  Dir.glob("spec/steps/**/*_steps.rb") { |f| require "./#{f}" }
end

RSpec.configure do |config|
  if config.files_to_run.size == 1
    config.default_formatter = 'doc'
  end

  config.color = true
end
