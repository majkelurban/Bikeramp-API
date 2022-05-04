# frozen_string_literal: true

require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource "Stats" do
  header "Accept", "application/json"
  header "Content-type", "application/json"
  header "Authorization", :token

  get "api/v1/stats/monthly" do
    let(:current_date) { Date.parse("15-05-2022") }
    let!(:month1_day1_trip1) { create(:trip, user: current_user, price: 2.50, distance: 10.30, delivery_date: current_date) }
    let!(:month1_day1_trip2) { create(:trip, user: current_user, price: 3.50, distance: 15.71, delivery_date: current_date) }
    let!(:month1_day2_trip1) { create(:trip, user: current_user, price: 12.64, distance: 10.50, delivery_date: current_date - 2) }
    let!(:month1_day2_trip2) { create(:trip, user: current_user, price: 22.50, distance: 8.60, delivery_date: current_date - 2) }
    let!(:month1_day3_trip1) { create(:trip, user: current_user, price: 21.70, distance: 8.60, delivery_date: current_date - 5) }

    let!(:month2_day1_trip1) { create(:trip, user: current_user, price: 42.50, distance: 10.30, delivery_date: current_date - 16) }
    let!(:month2_day1_trip2) { create(:trip, user: current_user, price: 3.50, distance: 15.70, delivery_date: current_date - 16 ) }
    let!(:month2_day2_trip1) { create(:trip, user: current_user, price: 32.50, distance: 10.50, delivery_date: current_date - 21) }
    let!(:month2_day2_trip2) { create(:trip, user: current_user, price: 12.50, distance: 15.62, delivery_date: current_date - 21) }
    let!(:month2_day3_trip1) { create(:trip, user: current_user, price: 1.50, distance: 1.60, delivery_date: current_date - 25) }

    before do
      Timecop.freeze("15-05-2022")
    end

    after do
      Timecop.return
    end

    context "200" do
      with_options required: false do
        parameter :ui_date, "Selected date", type: :date
      end

      let(:params) do
        {
          ui_date: Time.zone.today,
        }
      end

      example_request "Return monthly stats[SUCCESS]" do
        expect(response_status).to eq 200
      end
    end

    context "422 - Invalid params" do
      let(:params) do
        {
          ui_date: "string",
        }
      end

      example_request "Return monthly stats[FAILURE - invalid params]" do
        expect(response_status).to eq 422
      end
    end

    context "401" do
      let(:token)  { nil }
      let(:params) { {} }

      example_request "Return monthly stats[FAILURE - unauthorized]" do
        expect(response_status).to eq 401
      end
    end
  end
end
