module HackerNews
  module TopNews
    class TopNewsService
      def initialize(limit: 15)
        @limit = limit
      end

      def call
        Rails.cache.fetch(cache_key, expires_in: 1.hour) do
          fetch_and_cache_stories
        end
      end

      private

      def cache_key
        "top_stories_#{Time.now.to_date}_#{@limit}"
      end

      def fetch_and_cache_stories
        story_ids = HackerNews::BaseRequest::HnRequestService.new(url: 'topstories.json').call
        top_stories = process_top_stories(story_ids)
        top_stories.sort_by! { |story| story[:created_at] }.reverse!
        top_stories
      end

      def process_top_stories(story_ids)
        return unless story_ids.present?

        story_ids.take(@limit).map do |id|
          HackerNews::TopNews::StoryDetailsService.new(id).call
        end.compact
      end
    end
  end
end
