# frozen_string_literal: true

Geocoder.configure(
  # Geocoding options
  timeout:   3, # geocoding service timeout (secs)
  lookup:    :geoapify, # name of geocoding service (symbol)
  language:  :pl, # ISO-639 language code

  api_key:   Rails.application.credentials.geoapify_key,

  # Calculation options
  units:     :km, # :km for kilometers or :mi for miles
  distances: :linear          # :spherical or :linear
)
