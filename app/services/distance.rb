# frozen_string_literal: true

class Distance
  def calculate(start_address, end_address)
    @start_address = start_address
    @end_address = end_address

    Geocoder::Calculations.distance_between(start_cords, end_cords).round(2)
  end

  private

  attr_reader :start_address, :end_address

  def start_cords
    Geocoder.search(start_address).first&.coordinates
  end

  def end_cords
    Geocoder.search(end_address).first&.coordinates
  end
end
