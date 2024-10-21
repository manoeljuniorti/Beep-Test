# spec/services/hacker_news/daily_base_update/base_update_service_spec.rb

require 'rails_helper'

RSpec.describe HackerNews::DailyBaseUpdate::BaseUpdateService do
  let(:story_ids) { [1, 2, 3, 4, 5] }
  let(:story_data) { { id: 1, title: 'Test Story', url: 'https://example.com', score: 100, time: 1643723400 } }
  let(:comment_data) { { id: 1, text: 'Test Comment', by: 'user123', time: 1643723400 } }

  before do
    allow(HackerNews::BaseRequest::HnRequestService).to receive(:new).and_return(double(call: story_ids))
    allow(HackerNews::TopNews::StoryDetailsService).to receive(:new).and_return(double(call: story_data))
    allow(HackerNews::DailyBaseUpdate::CommentDetailService).to receive(:new).and_return(double(call: comment_data))
  end

  describe '.call' do
    it 'calls fetch_and_save_stories and fetch_and_save_comments' do
      expect(described_class).to receive(:fetch_and_save_stories).with(5)
      expect(described_class).to receive(:fetch_and_save_comments)
      described_class.call(5)
    end
  end

  describe '.fetch_and_save_stories' do
    let(:existing_story) { create(:story, id: 2) }

    before do
      allow(Story).to receive(:where).and_return(double(pluck: [2]))
      allow(described_class).to receive(:save_story)
    end

    it 'fetches story IDs' do
      expect(HackerNews::BaseRequest::HnRequestService).to receive(:new).with(url: 'topstories.json')
      described_class.send(:fetch_and_save_stories, 5)
    end

    it 'saves new stories' do
      expect(described_class).to receive(:save_story).with(story_data)
      described_class.send(:fetch_and_save_stories, 5)
    end

    it 'saves existing stories' do
      expect(described_class).to receive(:save_story).with(story_data)
      described_class.send(:fetch_and_save_stories, 5)
    end
  end

  describe '.save_story' do
    it 'creates or updates a story' do
      expect { described_class.send(:save_story, story_data) }.to change(Story, :count).by(1)
    end

    it 'returns true' do
      expect(described_class.send(:save_story, story_data)).to be true
    end
  end

  describe '.save_comment' do
    let(:story) { create(:story) }

    it 'creates or updates a comment' do
      expect { described_class.send(:save_comment, comment_data, story) }.to change(Comment, :count).by(1)
    end

    it 'returns true' do
      expect(described_class.send(:save_comment, comment_data, story)).to be true
    end
  end
end
