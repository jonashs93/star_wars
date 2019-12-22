require 'rails_helper'

RSpec.describe PersonService, type: :service do

  let(:attributes) do
    attributes = build(:person).attributes
    attributes['homeworld'] = 'https://swapi.co/api/planets/1/'
    attributes['species'] = ['https://swapi.co/api/species/1/']
    attributes['starships'] = ['https://swapi.co/api/starships/12/']
    attributes
  end

  subject { described_class.new(attributes) }

  describe '#new' do
    it { expect(subject.person.class).to eq(Person) }
    it { expect(subject.attributes).to be_truthy }
  end

  describe '#import' do
    it { expect { subject.import }.to change { Person.count }.by(1) }
    it { expect { subject.import }.to change { Homeworld.count }.by(1) }
    it { expect { subject.import }.to change { Specie.count }.by(1) }
    it { expect { subject.import }.to change { Starship.count }.by(1) }
    it { expect { subject.import }.to change { PersonDependent.count }.by(2) }
  end
end
