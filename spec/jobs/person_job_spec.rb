require 'rails_helper'

RSpec.describe PersonJob, type: :job do

  describe '#perform' do
    let(:attributes) do
      { 'name' => 'Luke Skywalker', 'mass' => '172', 'birth_year' => '19BBY',
        'homeworld' => '', 'species' => '', 'starships' => '' }
    end

    it 'send job' do
      ActiveJob::Base.queue_adapter = :test
      expect { PersonJob.perform_later(attributes) }.to have_enqueued_job
    end
  end
end
