# frozen_string_literal: true

module Trips
  module UseCases
    class Create < ::Monads
      def call
        yield validate(params)
        @distance = 21.20
        yield save_trip

        Success()
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
    end
  end
end
