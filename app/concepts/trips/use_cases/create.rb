# frozen_string_literal: true

module Trips
  module UseCases
    class Create < ::Monads
      def call
        yield validate(params)
        @distance = yield calculate_distance
        yield save_trip

        Success()
      end

      def calculate_distance
        distance = Distance.new.calculate(validated_params[:start_address], validated_params[:end_address])

        return Failure[__method__, full_error(code: distance_error_code, message: distance_error_message)] unless distance > 0

        Success(distance)
      end

      def save_trip
        Success(Trip.create!(trip_params))
      end

      private

      attr_reader :distance

      # HELPER METHODS

      def trip_params
        validated_params.merge(user_id: current_user.id, distance: distance)
      end

      def schema
        ::Trips::Schemas::Create.new
      end

      def distance_error_code
        "invalid_location"
      end

      def distance_error_message
        "One or both provided locations are invalid."
      end
    end
  end
end
