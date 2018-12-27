module ExceptionHandler
  extend ActiveSupport::Concern

  class AuthenticationError < StandardError; end
  class InvalidToken < StandardError; end
  class MissingToken < StandardError; end

  included do
    rescue_from ExceptionHandler::InvalidToken, with: :four_twenty_two
    rescue_from ExceptionHandler::MissingToken, with: :four_twenty_two
    rescue_from ActiveRecord::RecordInvalid, with: :four_twenty_two
    rescue_from ExceptionHandler::AuthenticationError, with: :unauthorized_entity

    rescue_from ActiveRecord::RecordNotFound do |e|
      json_response({ message: e.message }, :not_found)
    end
  end

  def four_twenty_two(e)
    json_response({ message: e.message }, :unprocessable_entity)
  end

  def unauthorized_entity(e)
    json_response({ message: e.message }, :unauthorized)
  end
end