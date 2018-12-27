require "rails_helper"

RSpec.describe "Users API", type: :request do
  # assign data to test
  let(:user) { build(:user) }
  let(:headers) { valid_headers.except("Authorization") }
  let(:valid_attributes) do
    attributes_for(:user, password_confirmation: user.password)
  end

  # test suite for signup
  describe "POST /signup" do
    # when request is valid
    context "when request is valid" do
      # post http request
      before { post "/signup", params: valid_attributes.to_json, headers: headers }

      it "returns http status code" do
        expect(response).to have_http_status(201)
      end

      it "returns auth token" do
        expect(json["auth_token"]).to_not be_nil
      end

      it "returns success message" do
        expect(json['message']).to match(/Account created successfully/)
      end
    end

    # when request is invalid
    context "when request is invalid" do
      # post http request
      before { post "/signup", params: {}, headers: headers }

      it "returns http status code" do
        expect(response).to have_http_status(422)
      end

      it "returns failure message" do
        expect(json["message"]).to match(/Validation failed: Password can't be blank, Name can't be blank, Email can't be blank, Password digest can't be blank/)
      end
    end
  end
end