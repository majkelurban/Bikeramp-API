# frozen_string_literal: true

module Trips
  module UseCases
    module Stats
      class FetchWeekly < ::Monads
        def call
          yield validate(params)
          stats = yield fetch_stats

          Success(stats)
        end

        def fetch_stats
          stats = Trip.select("SUM(distance) as total_distance, SUM(price) as total_price")
                      .where(user: current_user, delivery_date: range)
                      .group("user_id")
                      .order("user_id")

          Success(stats)
        end

        private

        attr_reader :distance

        # HELPER METHODS

        def range
          if validated_params[:ui_date].present?
            (validated_params[:ui_date].beginning_of_week)..(validated_params[:ui_date].end_of_week)
          else
            (Time.zone.today.beginning_of_week)..(Time.zone.today.end_of_week)
          end
        end

        def schema
          ::Trips::Schemas::Stats::FetchWeekly.new
        end
      end
    end
  end
end
