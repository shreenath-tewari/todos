require 'rails_helper'

RSpec.describe AuthorizeApiRequest do
  # create test user
  let!(:user) { create(:user) }

  # mock authorization header
  let!(:header) { { "Authorization" => token_generator(user.id) } }

  # create valid request
  subject(:invalid_request_object) { described_class.new({}) }

  # create invalid request
  subject(:request_object) { described_class.new(header) }

  # test suite for authorization
  describe "#call" do
    # check test when request is valid
    context "when request is valid" do
      it "returns user object" do
        result = request_object.call
        expect(result[:user]).to eq(user)
      end
    end

    # check test when request is invalid
    context "when request is invalid" do
      # test suite for missing token
      context "when missing token" do
        it "raises missing token error" do
          expect{ invalid_request_object.call }.to raise_error(ExceptionHandler::MissingToken, /Missing token/)
        end
      end

      # test suite for invalid token
      context "when invalid token" do
        let!(:header) { { "Authorization" => token_generator(5) } }
        subject(:invalid_request_object) { described_class.new(header) }

        it "raises invalid token error" do
          expect{ invalid_request_object.call }.to raise_error(ExceptionHandler::InvalidToken, /Invalid token/)
        end
      end

      # test suite if token is outdated
      context "when token is expired" do
        let!(:header) { { "Authorization" => expired_token_generator(user.id) } }
        subject(:request_object) { described_class.new(header) }

        it "raises ExceptionHandler::ExpiredSignature error" do
          expect{ request_object.call }.to raise_error(ExceptionHandler::InvalidToken, /Signature has expired/)
        end
      end

      # test suite if token is fake
      context "fake token" do
        let!(:header) { { "Authorization" => "foobar" } }
        subject(:invalid_request_object) { described_class.new(header) }

        it "handles JWT::DecodeError" do
          expect{ invalid_request_object.call }.to raise_error(ExceptionHandler::InvalidToken, /Not enough or too many segments/)
        end
      end
    end
  end
end