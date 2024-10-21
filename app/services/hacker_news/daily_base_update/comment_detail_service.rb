module HackerNews
  module DailyBaseUpdate
    class CommentDetailService
      def initialize(comment_id)
        @comment_id = comment_id
      end

      def call
        comment_data = HackerNews::BaseRequest::HnRequestService.new(url: "item/#{@comment_id}.json").call
        parse_comment(comment_data)
      end

      private

      def parse_comment(comment_data)
        return {} unless comment_data&.dig('type') == 'comment'

        {
          id: comment_data['id'],
          text: clean_comment_text(comment_data['text']),
          user: comment_data['by'],
          time: Time.at(comment_data['time']).in_time_zone('Brasilia').strftime("%d/%m/%Y %H:%M:%S"),
          parent_id: comment_data['parent']
        }
      end

      def clean_comment_text(text)
        return unless text.present?

        decoded_text = CGI.unescapeHTML(text)
        cleaned_text = decoded_text.gsub(/<[^>]*>/, '').gsub(/\s+/, ' ').gsub(/[^\w\s]$/, '')

        cleaned_text.strip.presence
      end
    end
  end
end
