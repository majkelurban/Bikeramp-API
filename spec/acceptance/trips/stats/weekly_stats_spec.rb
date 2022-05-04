# frozen_string_literal: true

require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource "Stats" do
  header "Accept", "application/json"
  header "Content-type", "application/json"
  header "Authorization", :token

  get "api/v1/stats/weekly" do
    let!(:week1_day1_trip1) { create(:trip, user: current_user, price: 2.50, distance: 10.30, delivery_date: Time.zone.today) }
    let!(:week1_day1_trip2) { create(:trip, user: current_user, price: 3.50, distance: 15.70, delivery_date: Time.zone.today) }
    let!(:week1_day2_trip1) { create(:trip, user: current_user, price: 2.50, distance: 10.50, delivery_date: Time.zone.today - 1) }

    let!(:week2_day4_trip1) { create(:trip, user: current_user, price: 12.50, distance: 8.50, delivery_date: Time.zone.today - 6) }

    before do
      Timecop.freeze("4-05-2022")
    end

    after do
      Timecop.return
    end

    context "200" do
      with_options required: false do
        parameter :ui_date, "Start address", type: :date
      end

      let(:params) do
        {
          ui_date: Time.zone.today,
        }
      end

      example_request "Return weekly stats[SUCCESS]" do
        expect(response_status).to eq 200
      end
    end

    context "422 - Invalid params" do
      let(:params) do
        {
          ui_date: "string",
        }
      end

      example_request "Return weekly stats[FAILURE - invalid params]" do
        expect(response_status).to eq 422
      end
    end

    context "401" do
      let(:token)  { nil }
      let(:params) { {} }

      example_request "Return weekly stats[FAILURE - unauthorized]" do
        expect(response_status).to eq 401
      end
    end
  end
end
