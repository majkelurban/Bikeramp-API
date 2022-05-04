# frozen_string_literal: true

module Trips
  module UseCases
    module Stats
      class FetchMonthly < ::Monads
        def call
          yield validate(params)
          stats = yield fetch_stats

          Success(stats)
        end

        def fetch_stats
          stats = Trip.select("delivery_date, SUM(distance) as total_distance, AVG(distance) as avg_ride, AVG(price) as avg_price")
                      .where(user: current_user, delivery_date: range)
                      .group("user_id, delivery_date")
                      .order("user_id, delivery_date")

          Success(stats)
        end

        private

        attr_reader :distance

        # HELPER METHODS

        def range
          if validated_params[:ui_date].present?
            (validated_params[:ui_date].beginning_of_month)..(validated_params[:ui_date].end_of_month)
          else
            (Time.zone.today.beginning_of_month)..(Time.zone.today.end_of_month)
          end
        end

        def schema
          ::Trips::Schemas::Stats.new
        end
      end
    end
  end
end
