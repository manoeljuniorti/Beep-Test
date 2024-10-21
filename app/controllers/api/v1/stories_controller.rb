module Api
  module V1
    class StoriesController < ApplicationController
      def index
        @stories = HackerNews::TopNews::TopNewsService.new(limit: 15).call
        render_json(@stories)
      end

      def search_hacker_news
        @results = HackerNews::Search::SearchService.new(
          params: permitted_search_params.merge(limit: 10)
        ).call
        render_json(@results)
      end

      private

      def permitted_search_params
        params.permit(:query, :page, :per_page).to_unsafe_h
      end
    end
  end
end
