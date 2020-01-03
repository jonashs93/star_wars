require 'rails_helper'

RSpec.describe PeopleController do

  describe 'GET #collection' do
    before do
      create(:person)
      get :collection
    end

    after { Person.destroy_all }

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

    it 'response data' do
      json_response = JSON.parse(response.body)
      expect(json_response['data']).to eq(JSON.parse(Person.all.to_json))
    end
  end

  subject { create(:person) }

  describe 'GET #show' do
    before do
      get :show, { params: { id: subject.id } }
    end

    after { Person.destroy_all }

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it 'response attributes' do
      json_response = JSON.parse(response.body)
      expect(json_response.keys).to match_array(['greeting'])
    end
  end

  describe '#greeting_message' do
    context "when language is english" do
      let(:greeting_message) do
        "Hello! My name is #{subject.name}. I am #{subject.species.first&.name}, I weigth #{subject.mass} kg, " \
        "I was born #{subject.homeworld&.name} in #{subject.birth_year} and #{controller.send(:starships, subject)}."
      end

      it "returns phrase in english" do
        expect(controller.send(:greeting_message, subject, 'en')).to eq(greeting_message)
      end
    end

    context "when language is portuguese" do
      let(:greeting_message) do
        "Olá! Meu nome é #{subject.name}. Sou um #{subject.species.first&.name}, peso #{subject.mass} kg, " \
        "nasci em #{subject.homeworld&.name} no ano #{subject.birth_year} e #{controller.send(:starships, subject)}."
      end

      it "returns phrase in portuguese" do
        expect(controller.send(:greeting_message, subject)).to eq(greeting_message)
      end
    end
  end

  describe '#starships' do
    context 'when has starships' do
      it do
        subject.stub(:starships).and_return([build(:starship)])
        message = "já pilotei #{subject.starships.map(&:name).to_sentence}"
        expect(controller.send(:starships, subject)).to eq(message)
      end
    end

    context "when hasn't starships" do
      it do
        subject.starships.destroy_all
        expect(controller.send(:starships, subject)).to eq('nunca pilotei')
      end
    end
  end
end
