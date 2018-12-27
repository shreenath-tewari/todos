require 'rails_helper'

describe AuthenticateUser do
  # create user
  let(:user) { create(:user) }

  # create valid obj credentials
  subject(:valid_auth_obj) { described_class.new(user.email, user.password) }

  # create invalid object credentials
  subject(:invalid_auth_obj) { described_class.new("foo", "bar") }

  # test suite for call method
  describe "#call" do
    # check if credentials are valid
    context "when valid credentials" do
      it "returns an auth token" do
        token = valid_auth_obj.call
        expect(token).not_to be_nil
      end
    end

    # check if credentials are invalid
    context "when invalid credentials" do
      it "should display failure message" do
        expect{ invalid_auth_obj.call }.to raise_error(ExceptionHandler::AuthenticationError, /Invalid credentials/)
      end
    end
  end
end