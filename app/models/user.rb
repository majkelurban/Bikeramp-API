# frozen_string_literal: true

class User < ApplicationRecord
  has_many :trips, dependent: :destroy
end
