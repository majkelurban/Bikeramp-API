# frozen_string_literal: true

RSpec.configure do |config|
  config.color = true
  config.tty = true
  config.formatter = :doc

  config.order = :random

  Kernel.srand config.seed
end
