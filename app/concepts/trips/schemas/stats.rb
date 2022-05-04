# frozen_string_literal: true

module Trips
  module Schemas
    class Stats < ::ApplicationContract
      params do
        optional(:ui_date).maybe(:date)
      end
    end
  end
end
