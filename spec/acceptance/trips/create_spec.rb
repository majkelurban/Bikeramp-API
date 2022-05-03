# frozen_string_literal: true

require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource "Trips" do
  header "Accept", "application/json"
  header "Content-type", "application/json"
  header "Authorization", :token

  post "api/v1/trips" do
    context "201" do
      with_options required: true do
        parameter :start_address, "Start address", type: :string
        parameter :end_address,   "End address",   type: :string
        parameter :price,         "Start address", type: :float
        parameter :delivery_date, "Start address", type: :date
      end

      let(:params) do
        {
          price:         31.50,
          delivery_date: Time.zone.today,
          start_address: "Gliniana 5, Lublin, Polska",
          end_address:   "Zielonaa 32, Lublin, Polska"
        }
      end

      example_request "Create trip [SUCCESS]" do
        expect(response_status).to eq 201
      end
    end

    context "422 - Invalid params" do
      let(:params) do
        {
          price:         "price",
          delivery_date: Time.zone.today,
          start_address: "Gliniana 5, Lublin, Polska",
          end_address:   "Zielonaa 32, Lublin, Polska"
        }
      end

      example_request "Create trip [FAILURE - invalid params]" do
        expect(response_status).to eq 422
      end
    end

    context "422 - Invalid locations" do
      let(:params) do
        {
          price:         30.40,
          delivery_date: Time.zone.today,
          start_address: " ,  ,  ",
          end_address:   "Zielonaa 32, Lublin, Polska"
        }
      end

      example_request "Create trip [FAILURE - invalid locations]" do
        expect(response_status).to eq 422
      end
    end

    context "401" do
      let(:token) { nil }
      let(:params) do
        {
          price:         "price",
          delivery_date: Time.zone.today,
          start_address: "Gliniana 5, Lublin, Polska",
          end_address:   "Zielonaa 32, Lublin, Polska"
        }
      end

      example_request "Create trip [FAILURE - unauthorized]" do
        expect(response_status).to eq 401
      end
    end
  end
end
