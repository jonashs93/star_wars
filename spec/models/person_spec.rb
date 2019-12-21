require 'rails_helper'

RSpec.describe Person, type: :model do

  context 'associations' do
    it { should belong_to(:homeworld) }
    it { should have_many(:dependents) }
    it { should have_many(:starships) }
    it { should have_many(:species) }

  end

  context 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_most(100) }
    it { should validate_presence_of(:mass) }
  end
end
