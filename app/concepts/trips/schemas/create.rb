# frozen_string_literal: true

module Trips
  module Schemas
    class Create < ::ApplicationContract
      params do
        required(:start_address).filled(:string)
        required(:end_address).filled(:string)
        required(:delivery_date).filled(:date)
        required(:price).filled(:float)
      end

      rule(:start_address) do
        key.failure("is invalid") unless
          values[:start_address].split(",").length == 3
      end

      rule(:end_address) do
        key.failure("is invalid") unless
          values[:end_address].split(",").length == 3
      end
    end
  end
end
