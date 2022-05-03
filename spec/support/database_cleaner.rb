# frozen_string_literal: true

if ENV.fetch("RAILS_ENV").eql?("test")
  puts "spec/support/database_cleaner.rb: Loading DatabaseCleaner"
  require "database_cleaner/active_record"

  RSpec.configure do |config|
    config.before(:suite) do
      DatabaseCleaner.clean_with(:truncation)
    end

    config.before do
      DatabaseCleaner.strategy = :transaction
    end

    config.before do
      DatabaseCleaner.start
    end

    config.after do
      DatabaseCleaner.clean
    end
  end
end
