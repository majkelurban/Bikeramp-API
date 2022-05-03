# frozen_string_literal: true

describe Trips::UseCases::Create do
  subject(:create_trip) { described_class.new(params, current_user).call }

  context "when params are invalid" do
    context "when params are missing" do
      let(:params) { {} }

      let(:error_message) do
        {
          code:             "validation_error",
          message:          nil,
          parameter_errors: [
            {
              code: "key",
              path: [:start_address],
              text: "is missing"
            },
            {
              code: "key",
              path: [:end_address],
              text: "is missing"
            },
            {
              code: "key",
              path: [:delivery_date],
              text: "is missing"
            },
            {
              code: "key",
              path: [:price],
              text: "is missing"
            }
          ]
        }
      end

      it "is failure" do
        expect(create_trip).to be_failure
      end

      it "contains error messge" do
        expect(create_trip.failure[1]).to match(error_message)
      end

      it "doesn't create trip" do
        expect { create_trip }.not_to change(Trip, :count)
      end
    end

    context "when address has wrong format" do
      let(:params) do
        {
          price:         31.50,
          delivery_date: Time.zone.today,
          start_address: "Gliniana 5, Lublin, Polska",
          end_address:   "Lublin, Polska"
        }
      end

      let(:error_message) do
        {
          code:             "validation_error",
          message:          nil,
          parameter_errors: [
            {
              code: "",
              path: [:end_address],
              text: "is invalid"
            }
          ]
        }
      end

      it "is failure" do
        expect(create_trip).to be_failure
      end

      it "contains error messge" do
        expect(create_trip.failure[1]).to match(error_message)
      end

      it "doesn't create trip" do
        expect { create_trip }.not_to change(Trip, :count)
      end
    end

    context "when address doesn't exist" do
      let(:params) do
        {
          price:         31.50,
          delivery_date: Time.zone.today,
          start_address: "Gliniana 5, Lublin, Polska",
          end_address:   " , , "
        }
      end

      let(:error_message) do
        {
          code:             "invalid_location",
          message:          "One or both provided locations are invalid.",
          parameter_errors: nil
        }
      end

      it "is failure" do
        expect(create_trip).to be_failure
      end

      it "contains error messge" do
        expect(create_trip.failure[1]).to match(error_message)
      end

      it "doesn't create trip" do
        expect { create_trip }.not_to change(Trip, :count)
      end
    end
  end

  context "when params are valid" do
    let(:params) do
      {
        price:         31.50,
        delivery_date: Time.zone.today,
        start_address: "Gliniana 5, Lublin, Polska",
        end_address:   "Zielonaa 32, Lublin, Polska"
      }
    end

    it "is success" do
      expect(create_trip).to be_success
    end

    it "creates trip" do
      expect{ create_trip }.to change(Trip, :count).from(0).to(1)
    end
  end
end
