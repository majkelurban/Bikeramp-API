# frozen_string_literal: true

ENV["RAILS_ENV"] = "test"

require File.expand_path("../config/environment", __dir__)
abort("The rails environment is running in production mode!") if Rails.env.production?

require "spec_helper"
require "rspec/rails"

Dir["./spec/support/**/*.rb"].sort.each { |f| require f }

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end
