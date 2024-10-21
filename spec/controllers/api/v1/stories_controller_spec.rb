# spec/controllers/api/v1/stories_controller_spec.rb

require 'rails_helper'

RSpec.describe Api::V1::StoriesController, type: :controller do
  describe '#index' do
    let(:top_news_service) { instance_double(HackerNews::TopNews::TopNewsService) }
    let(:stories) { [{ id: 1, title: 'Test Story' }] }

    before do
      allow(HackerNews::TopNews::TopNewsService).to receive(:new).with(limit: 15).and_return(top_news_service)
      allow(top_news_service).to receive(:call).and_return(stories)
    end

    it 'calls TopNewsService with correct limit' do
      get :index, format: :json
      expect(HackerNews::TopNews::TopNewsService).to have_received(:new).with(limit: 15)
    end

    it 'renders stories in JSON response' do
      get :index, format: :json
      expect(response.body).to eq(stories.to_json)
    end

    it 'renders JSON response' do
      get :index, format: :json
      expect(response.content_type).to include('application/json')
    end
  end

  describe '#search_hacker_news' do
    let(:search_service) { instance_double(HackerNews::Search::SearchService) }
    let(:results) { [{ id: 1, title: 'Search Result' }] }

    before do
      allow(HackerNews::Search::SearchService).to receive(:new).with(any_args).and_return(search_service)
      allow(search_service).to receive(:call).and_return(results)
    end

    it 'calls SearchService with correct parameters' do
      get :search_hacker_news, params: { query: 'test', page: 1, per_page: 10, format: :json }
      expect(HackerNews::Search::SearchService).to have_received(:new).with(hash_including(params: hash_including(query: 'test')))
    end

    it 'renders results in JSON response' do
      get :search_hacker_news, params: { query: 'test', format: :json }
      expect(response.body).to eq(results.to_json)
    end

    it 'renders JSON response' do
      get :search_hacker_news, params: { query: 'test', format: :json }
      expect(response.content_type).to include('application/json')
    end
  end
end
