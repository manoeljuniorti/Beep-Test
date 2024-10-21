# spec/services/hacker_news/top_news/top_news_service_spec.rb

require 'rails_helper'

RSpec.describe HackerNews::TopNews::TopNewsService do
  let(:limit) { 15 }
  let(:story_ids) { [1, 2, 3, 4, 5] }
  let(:story_data) { { id: 1, title: 'Test Story', url: 'https://example.com', score: 100, time: 1643723400 } }

  before do
    allow(HackerNews::BaseRequest::HnRequestService).to receive(:new).and_return(double(call: story_ids))
    allow(HackerNews::TopNews::StoryDetailsService).to receive(:new).and_return(double(call: story_data))
  end

  describe '#initialize' do
    it 'sets the limit' do
      service = described_class.new(limit: 10)
      expect(service.instance_variable_get(:@limit)).to eq(10)
    end

    it 'uses default limit when not provided' do
      service = described_class.new
      expect(service.instance_variable_get(:@limit)).to eq(15)
    end
  end

  describe '#call' do
    it 'uses cache' do
      expect(Rails.cache).to receive(:fetch).with("top_stories_#{Time.now.to_date}_#{limit}", expires_in: 1.hour)
      described_class.new(limit: limit).call
    end

    it 'sorts stories by created_at in descending order' do
      allow(HackerNews::TopNews::StoryDetailsService).to receive(:new).and_return(double(call: story_data.merge(created_at: Time.now)))
      allow(Time).to receive(:now).and_return(Time.new(2023, 1, 1))
      result = described_class.new(limit: limit).call
      expect(result.first[:created_at]).to be > Time.now
    end
  end

  describe '#cache_key' do
    it 'generates a unique cache key based on date and limit' do
      allow(Time).to receive(:now).and_return(Time.new(2023, 1, 1))
      expect(described_class.new(limit: 10).send(:cache_key)).to eq("top_stories_2023-01-01_10")
    end
  end

  describe '#fetch_and_cache_stories' do
    it 'fetches story IDs' do
      expect(HackerNews::BaseRequest::HnRequestService).to receive(:new).with(url: 'topstories.json')
      described_class.new(limit: limit).send(:fetch_and_cache_stories)
    end
  end

  describe '#process_top_stories' do
    it 'processes story IDs' do
      expect(HackerNews::TopNews::StoryDetailsService).to receive(:new).with(story_ids.first)
      described_class.new(limit: limit).send(:process_top_stories, story_ids)
    end

    it 'limits the number of stories' do
      allow(HackerNews::TopNews::StoryDetailsService).to receive(:new).and_return(double(call: story_data))
      result = described_class.new(limit: 3).send(:process_top_stories, story_ids)
      expect(result.size).to eq(3)
    end
  end
end
