# frozen_string_literal: true

module Trips
  module Representers
    class WeeklyStats < ::Representer
      represent_with :total_distance,
                     :total_price

      def total_distance
        "#{resource.first.total_distance}km"
      end

      def total_price
        "#{resource.first.total_price}PLN"
      end
    end
  end
end
