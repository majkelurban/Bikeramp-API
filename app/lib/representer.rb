# frozen_string_literal: true

class Representer
  class << self
    def one(resource, current_user = nil)
      new(resource, current_user).map(properties)
    end

    def all(resources, current_user = nil)
      resources.map { |resource| one(resource, current_user) }
    end

    private

    attr_reader :properties
  end

  def map(properties)
    return unless resource

    properties.index_with { |properrty| send(properrty) }
  end

  private

  attr_reader :resource, :current_user

  def initialize(resource, current_user = nil)
    @resource = resource
    @current_user = current_user
  end
end
