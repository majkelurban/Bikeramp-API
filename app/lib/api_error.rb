# frozen_string_literal: true

module ApiError
  include Dry::Monads::Result::Mixin

  delegate :to_h, :errors, to: :result

  alias_method :validated_params, :to_h

  def schema
    raise NotImplementedError
  end

  def validate(params)
    @result = schema.call(params.to_h)
    error = full_error(code: "validation_error", parameter_errors: result.errors)
    result.success? ? Success(result.to_h) : Failure(error)
  end

  def full_error(code:, message: nil, parameter_errors: nil)
    {
      code:             code,
      message:          message,
      parameter_errors: parse_e(parameter_errors)
    }
  end

  private

  def parse_e(parameter_errors)
    return nil unless parameter_errors

    parameter_errors.map do |error|
      {
        code: error.predicate.to_s.delete("?"),
        path: error.path,
        text: error.text
      }
    end
  end

  attr_reader :result
end
