require 'rails_helper'

RSpec.describe "People", type: :request do
  describe "GET /people" do
    it "returns http success and render index template" do
      get "/people"
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:index)
    end
  end

  describe "GET /people/:id for type Employee" do
    it "returns http success and render show template" do
      get "/people/1", params: {type: 'employee'}
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:show)
    end
  end

  describe "GET /people/:id for type Candidate" do
    it "returns http success and render show template" do
      get "/people/2", params: {type: 'candidate'}
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:show)
    end
  end

  describe "POST /peoples for type Employee" do
    it "returns http success and render show template" do
      post "/people", params: {person: {name: 'RspecEmployee', email: 'rspec@emp.com', experience: 20, type: 'Employee'}}
      expect(response).to have_http_status(302)
      expect(response).to redirect_to(list_url(type: 'employee'))
    end
  end

  describe "POST /peoples for type Candidate" do
    it "returns http success and render show template" do
      post "/people", params: {person: {name: 'RspecCandidate', email: 'rspec@can.com', experience: 20, type: 'Candidate'}}
      expect(response).to have_http_status(302)
      expect(response).to redirect_to(list_url(type: 'candidate'))
    end
  end

end
