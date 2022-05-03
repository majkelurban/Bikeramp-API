# frozen_string_literal: true

describe Authorization::Auth do
  subject(:authorize_request) do
    described_class.new.call("Authorization" => token)
  end

  let(:user)  { create(:user) }
  let(:token) { ::Authorization::JsonWebToken.encode({ id: user.id }).to_s }

  context "when token is valid" do
    it "returns user id" do
      expect(authorize_request.success[:id]).to eq(user.id)
    end
  end

  context "when token is missing" do
    let(:token) { nil }

    it "returns error" do
      expect(authorize_request.failure).not_to be_nil
    end
  end
end
