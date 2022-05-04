# frozen_string_literal: true

describe Trips::UseCases::Stats::FetchWeekly do
  subject(:weekly_stats) { described_class.new(params, current_user).call }

  let!(:week1_day1_trip1) { create(:trip, user: current_user, price: 2.50, distance: 10.30, delivery_date: Time.zone.today) }
  let!(:week1_day1_trip2) { create(:trip, user: current_user, price: 3.50, distance: 15.70, delivery_date: Time.zone.today) }
  let!(:week1_day2_trip1) { create(:trip, user: current_user, price: 2.50, distance: 10.50, delivery_date: Time.zone.today - 1) }
  let!(:week1_day3_trip1) { create(:trip, user: current_user, price: 2.50, distance: 8.60, delivery_date: Time.zone.today - 2) }

  let!(:week2_day1_trip1) { create(:trip, user: current_user, price: 10.50, distance: 18.50, delivery_date: Time.zone.today - 3) }
  let!(:week2_day2_trip1) { create(:trip, user: current_user, price: 12.50, distance: 28.50, delivery_date: Time.zone.today - 4) }
  let!(:week2_day3_trip1) { create(:trip, user: current_user, price: 42.50, distance: 11.50, delivery_date: Time.zone.today - 5) }
  let!(:week2_day4_trip1) { create(:trip, user: current_user, price: 12.50, distance: 8.50, delivery_date: Time.zone.today - 6) }

  let!(:week3_day1_trip1) { create(:trip, user: current_user, price: 2.50, distance: 8.50, delivery_date: Time.zone.today - 14) }

  before do
    Timecop.freeze("4-05-2022")
  end

  after do
    Timecop.return
  end

  context "when user didn't provide date" do
    let(:params) { {} }

    it "returns current week stats" do
      expect(weekly_stats.success.first.attributes.symbolize_keys).to eq({ id: nil, total_price: 11.00, total_distance: 45.10 })
    end
  end

  context "when user provided date" do
    let(:params) do
      {
        ui_date: Time.zone.today - 7
      }
    end

    it "returns current week stats" do
      expect(weekly_stats.success.first.attributes.symbolize_keys).to eq({ id: nil, total_price: 78.00, total_distance: 67.00 })
    end
  end
end
