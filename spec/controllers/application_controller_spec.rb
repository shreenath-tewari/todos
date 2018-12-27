require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  # create test user
  let(:user) { create(:user) }

  # create headers
  let(:headers) { { "Authorization" => token_generator(user.id) } }
  let(:invalid_headers) { { "Authorization" => nil } }

  # test suite for authorize_request
  describe "#authroize_request" do
    # when request is valid
    context "when auth token is passed" do
      # http request
      before { allow(request).to receive(:headers).and_return(headers) }

      it "returns current user" do
        expect(subject.instance_eval{ authorize_request }).to eq(user)
      end
    end

    # when request is invalid
    context "when auth token is not passed" do
      # http request
      before { allow(request).to receive(:headers).and_return(invalid_headers) }

      it "raises MissingToken error" do
        expect { subject.instance_eval{ authorize_request } }.to raise_error(ExceptionHandler::MissingToken, /Missing token/)
      end
    end
  end
end