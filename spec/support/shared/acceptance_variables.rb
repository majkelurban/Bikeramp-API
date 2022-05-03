# frozen_string_literal: true

RSpec.shared_context "with logged user" do
  let(:current_user) { create(:user) }
  let(:token)        { ::Authorization::JsonWebToken.encode({ id: current_user.id }).to_s }
end

RSpec.configure do |rspec|
  rspec.include_context "with logged user"
end
