require 'rails_helper'

RSpec.describe Homeworld, type: :model do

  context 'associations' do
    it { should have_many(:people) }
  end

  context 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_most(100) }
  end
end
