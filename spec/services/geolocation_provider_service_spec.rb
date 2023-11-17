# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GeolocationProviderService do
  describe '#lookup' do
    let(:ip) { '127.0.0.1' }
    let(:service) { described_class.new }
    let(:response) { instance_double(Faraday::Response, body: response_body, success?: true) }
    let(:response_body) do
      {
        'ip' => '127.0.0.1',
        'type' => 'ipv4',
        'continent_code' => 'NA',
        'continent_name' => 'North America',
        'country_code' => 'US',
        'country_name' => 'United States'
      }.to_json
    end

    before do
      allow(Faraday).to receive(:get).and_return(response)
    end

    context 'when the request is successful' do
      it 'returns parsed JSON' do
        result = service.lookup(ip)
        expect(result).to include('ip' => '127.0.0.1', 'country_name' => 'United States')
      end
    end

    context 'when the request fails' do
      let(:error) { Faraday::ConnectionFailed.new('Connection failed') }

      before do
        allow(Faraday).to receive(:get).and_raise(error)
      end

      it 'raises an error' do
        expect { service.lookup(ip) }.to raise_error(Faraday::ConnectionFailed, 'Connection failed')
      end
    end
  end
end
