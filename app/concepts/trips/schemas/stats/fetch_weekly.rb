# frozen_string_literal: true

module Trips
  module Schemas
    module Stats
      class FetchWeekly < ::ApplicationContract
        params do
          optional(:ui_date).maybe(:date)
        end
      end
    end
  end
end
