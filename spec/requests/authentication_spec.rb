require 'rails_helper'

RSpec.describe 'Authentication', type: :request do
  # test suite for login
  describe "POST /auth/login" do
    # declare data set
    let!(:user) { create(:user) }
    let(:headers) { valid_headers.except("Authorization") }
    let(:valid_attributes) do
      { email: user.email, password: user.password }.to_json
    end
    let(:invalid_attributes) do
      { email: Faker::Internet.email, password: Faker::Internet.password }.to_json
    end

    # when request is valid
    context "when credentials are valid" do
      # post http request
      before { post '/auth/login', params: valid_attributes, headers: headers }

      it "returns auth token" do
        expect(json["auth_token"]).not_to be_nil
      end
    end

    # when request is invalid
    context "when credentials are invalid" do
      # post http request
      before { post '/auth/login', params: invalid_attributes, headers: headers }

      it "returns failure message" do
        expect(json['message']).to match(/Invalid credentials/)
      end
    end

  end
end