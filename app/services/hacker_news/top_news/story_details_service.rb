module HackerNews
  module TopNews
    class StoryDetailsService
      def initialize(story_id)
        @story_id = story_id
      end

      def call
        story_data = HackerNews::BaseRequest::HnRequestService.new(url: "item/#{@story_id}.json").call
        parse_story(story_data)
      end

      private

      def parse_story(story_data)
        return {} unless story_data.present?

        HackerNews::Parser.treat_response(story_data)
      end
    end
  end
end
