# frozen_string_literal: true

module Trips
  module Representers
    class MonthlyStats < ::Representer
      represent_with :day,
                     :total_distance,
                     :avg_ride,
                     :avg_price

      def day
        resource.delivery_date.strftime("%Y %B, #{resource.delivery_date.day.ordinalize}")
      end

      def total_distance
        "#{resource.total_distance}km"
      end

      def avg_ride
        "#{resource.avg_ride.round(2)}km"
      end

      def avg_price
        "#{resource.avg_price.round(2)}PLN"
      end
    end
  end
end
