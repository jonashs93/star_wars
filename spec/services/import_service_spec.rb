require 'rails_helper'

RSpec.describe ImportService, type: :service do

  subject { ImportService.new('https://swapi.co/api/people') }

  describe '#execute' do
    it "should call get_data, send_job and get_next_url" do
      subject.stub(:get_data).and_return({ 'results' => [1]})
      subject.stub(:send_job)
      subject.stub(:get_next_url)

      expect(subject).to receive(:send_job).exactly(1).times
      expect(subject).to receive(:get_data).at_least(:once)
      expect(subject).to receive(:get_next_url).at_least(:once)

      subject.execute
    end
  end

  describe '#get_data' do
    it 'shoud return HTTParty' do
      get_data_return = subject.send(:get_data).class
      expect(get_data_return).to eq(HTTParty::Response)
    end
  end

  describe '#get_next_url' do
    it 'shoud take next url in data' do
      parsed_response = Struct.new(:parsed_response).new('next' => 'https://next_url/1')
      subject.stub(:data).and_return(parsed_response)

      expect(subject.send(:get_next_url)).to eq('https://next_url/1')
    end
  end
end
