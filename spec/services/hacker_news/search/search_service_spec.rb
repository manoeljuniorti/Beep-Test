# spec/services/hacker_news/search/search_service_spec.rb

require 'rails_helper'

RSpec.describe HackerNews::Search::SearchService do
  let(:params) { { query: 'TESTE', page: 1, per_page: 10 } }

  before do
    @story1 = create(:story, title: 'Test Story 1', url: 'https://example.com/test1')
    @story2 = create(:story, title: 'Test Story 2', url: 'https://example.com/test2')
    @comment1 = create(:comment, text: 'This is a test comment 1', story: @story1)
    @comment2 = create(:comment, text: 'This is a test comment 2', story: @story2)
  end

  describe '#call' do
    it 'returns a hash with pagination info and results' do
      result = described_class.new(params: params).call
      expect(result).to be_a(Hash)
      expect(result.keys).to eq([:pagination, :result])
      expect(result[:pagination]).to be_a(Hash)
      expect(result[:result]).to be_a(Hash)
      expect(result[:result].keys).to eq([:stories, :comments])
    end
  end
end
