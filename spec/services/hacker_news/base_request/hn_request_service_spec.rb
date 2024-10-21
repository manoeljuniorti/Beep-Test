require 'rails_helper'

RSpec.describe HackerNews::BaseRequest::HnRequestService do
  let(:base_url) { 'https://api.hackernews.com' }
  let(:url) { 'v0/topstories.json' }
  let(:service) { described_class.new(url: url) }

  before do
    allow(ENV).to receive(:fetch).with('BASE_URL').and_return(base_url)
  end

  describe '#call' do
    context 'when the request is successful' do
      let(:response_body) { { 'key' => 'value' } }
      let(:response) { instance_double(HTTParty::Response, parsed_response: response_body, success?: true) }

      before do
        allow(HTTParty).to receive(:get).with("#{base_url}/#{url}").and_return(response)
      end

      it 'returns the parsed response' do
        expect(service.call).to eq(response_body)
      end
    end

    context 'when the request fails' do
      let(:error) { StandardError.new('Test error') }
      let(:response) { instance_double(HTTParty::Response, success?: false) }

      before do
        allow(HTTParty).to receive(:get).with("#{base_url}/#{url}").and_raise(error)
      end

      it 'logs the error and returns nil' do
        expect(Rails.logger).to receive(:error).with("Erro na requisição para #{base_url}/#{url}: Test error")
        expect(service.call).to be_nil
      end
    end
  end

  describe '#get_request' do
    let(:response) { instance_double(HTTParty::Response, parsed_response: { 'key' => 'value' }, success?: true) }

    before do
      allow(HTTParty).to receive(:get).with("#{base_url}/#{url}").and_return(response)
    end

    it 'returns the parsed response when successful' do
      expect(service.send(:get_request)).to eq({ 'key' => 'value' })
    end

    context 'when the request fails' do
      let(:response) { instance_double(HTTParty::Response, success?: false) }

      it 'returns nil' do
        expect(service.send(:get_request)).to be_nil
      end
    end
  end
end
