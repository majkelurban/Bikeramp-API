# frozen_string_literal: true

describe Trips::UseCases::Stats::FetchMonthly do
  subject(:monthly_stats) { described_class.new(params, current_user).call }

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

  context "when its current month" do
    let(:params) { {} }

    let(:result) {
      [
        {
          "id"             => nil,
          "delivery_date"  => "2022-05-10",
          "total_distance" => "8.6",
          "avg_ride"       => "8.6",
          "avg_price"      => "21.7"
        },
        {
          "id"             => nil,
          "delivery_date"  => "2022-05-13",
          "total_distance" => "19.1",
          "avg_ride"       => "9.55",
          "avg_price"      => "17.57"
        },
        {
          "id"             => nil,
          "delivery_date"  => "2022-05-15",
          "total_distance" => "26.01",
          "avg_ride"       => "13.005",
          "avg_price"      => "3.0"
        }
      ]
    }

    it "returns current month stats" do
      expect(monthly_stats.success.as_json).to match_array(result)
    end
  end

  context "when its previous month" do
    let(:params) do
      {
        ui_date: Time.zone.today - 16
      }
    end

    let(:result) {
      [
        {
          "id"             => nil,
          "delivery_date"  => "2022-04-20",
          "total_distance" => "1.6",
          "avg_ride"       => "1.6",
          "avg_price"      => "1.5"
        },
        {
          "id"             => nil,
          "delivery_date"  => "2022-04-24",
          "total_distance" => "26.12",
          "avg_ride"       => "13.06",
          "avg_price"      => "22.5"
        },
        {
          "id"             => nil,
          "delivery_date"  => "2022-04-29",
          "total_distance" => "26.0",
          "avg_ride"       => "13.0",
          "avg_price"      => "23.0"
        }
      ]
    }

    it "returns last month stats" do
      expect(monthly_stats.success.as_json).to match_array(result)
    end
  end
end
