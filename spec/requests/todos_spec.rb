require 'rails_helper'

RSpec.describe "Todos API", type: :request do
  # get test data
  let!(:user) { create(:user) }
  let!(:todos) { create_list(:todo, 10, created_by: user.id) }
  let(:todo_id) { todos.first.id }
  let(:headers) { valid_headers }

  # for index action
  describe "GET /todos" do
    #get http request
    before { get "/todos", params: {}, headers: headers }

    #check for tests
    it "returns todos" do
      expect(json).to_not be_empty
      expect(json.size).to eq(10)
    end

    it "returns status code 200" do
      expect(response).to have_http_status(200)
    end
  end

  # for show action
  describe "GET /todos/:id" do
    #get http request
    before { get "/todos/#{todo_id}", params: {}, headers: headers }

    # check for tests
    context "when record exists" do
      it "returns a todo" do
        expect(json["id"]).to eq(todo_id)
      end

      it "returns status code 200" do
        expect(response).to have_http_status(200)
      end
    end
  end

  # for create action
  describe "POST /todos" do
    # create valid attributes
    let!(:valid_attributes) { { title: "Barca", created_by: user.id.to_s }.to_json }

    # check for tests
    context "when request is valid" do
      # valid post http request
      before { post "/todos", params: valid_attributes, headers: headers }

      it "creates a todo" do
        expect(json["title"]).to eq("Barca")
      end

      it "returns status code 201" do
        expect(response).to have_http_status(201)
      end
    end

    context "when request is invalid" do
      # invalid put http request
      let(:invalid_attributes) { { title: nil }.to_json }
      before { post "/todos", params: invalid_attributes, headers: headers }

      it "returns status code 422" do
        expect(response).to have_http_status(422)
      end

      it "returns validation failure message" do
        expect(json['message']).to match(/Validation failed: Title can't be blank/)
      end
    end
  end

  # for update action
  describe "PUT /todos/:id" do
    # valid attributes definition
    let!(:valid_attributes) { { title: "Bayern" }.to_json }

    # check for tests
    context "when request is valid" do
      # put http request
      before{ put "/todos/#{todo_id}", params: valid_attributes, headers: headers }

      it "updates a todo" do
        expect(response.body).to be_empty
      end

      it "returns status code 204" do
        expect(response).to have_http_status(204)
      end
    end
  end

  # for delete action
  describe "DELETE /todos/:id" do
    # delete http request
    before { delete "/todos/#{todo_id}", params: {}, headers: headers }

    # check for tests
    context "when record exists" do
      it "returns status code 204" do
        expect(response).to have_http_status(204)
      end

      it "deletes a record" do
        expect(response.body).to be_empty
      end
    end
  end

end