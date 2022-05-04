# frozen_string_literal: true

module Api
  module V1
    class TripsController < ApplicationController
      def create
        case ::Trips::UseCases::Create.new(params, current_user).call
        in Success()
          head :created
        in :validate, error
          render json: { errors: error }, status: :unprocessable_entity
        in :calculate_distance, error
          render json: { errors: error }, status: :unprocessable_entity
        end
      end

      def weekly_stats
        case ::Trips::UseCases::Stats::FetchWeekly.new(params, current_user).call
        in Success(stats)
          render json: ::Trips::Representers::WeeklyStats.one(stats)
        in :validate, errors
          render json: { errors: errors }, status: :unprocessable_entity
        end
      end

      def monthly_stats
        case ::Trips::UseCases::Stats::FetchMonthly.new(params, current_user).call
        in Success(stats)
          render json: ::Trips::Representers::MonthlyStats.all(stats)
        in :validate, errors
          render json: { errors: errors }, status: :unprocessable_entity
        end
      end
    end
  end
end
