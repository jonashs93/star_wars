require 'rails_helper'

RSpec.describe PersonDependent, type: :model do

  context 'associations' do
    it { should belong_to(:person) }
    it { should belong_to(:dependent) }
  end

  context 'validations' do
    it { should validate_presence_of(:person) }
    it { should validate_presence_of(:dependent) }    
  end
end
