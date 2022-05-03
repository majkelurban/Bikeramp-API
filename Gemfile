source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.7.4"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.0.2", ">= 7.0.2.4"
gem "pg", "~> 1.1"
gem "puma", "~> 5.0"
gem "bootsnap", require: false
gem "dry-validation"
gem "dry-monads"


group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
  gem "pry"
  gem "rspec-rails"
  gem "factory_bot"
  gem "factory_bot_rails"
  gem "amazing_print"
  gem "faker"
end

group :development do
  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
  gem "rubocop"
  gem "relaxed-rubocop"
  gem "rubocop-rails"
  gem "rubocop-rspec"
end

