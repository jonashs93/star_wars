require 'rails_helper'

RSpec.describe PeopleController do

  describe 'GET collection' do
    before do
      create(:person)
      get :collection
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    let(:keys) do
      ['total', 'per_page', 'current_page', 'last_page', 'prev_page_url',
       'next_page_url', 'from', 'to', 'data']
    end

    it 'response attributes' do
      json_response = JSON.parse(response.body)
      expect(json_response.keys).to match_array(keys)
    end

    it 'results data' do
      json_response = JSON.parse(response.body)
      expect(json_response['data']).to eq(JSON.parse(Person.all.to_json))
    end
  end
end
