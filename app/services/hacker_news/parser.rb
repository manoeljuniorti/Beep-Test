module HackerNews
  class Parser
    class << self
      def treat_response(story_data)
        return unless story_data&.dig('type') == 'story'

        {
          id: story_data['id'],
          title: story_data['title'],
          url: story_data['url'],
          score: story_data['score'],
          comments: relevant_comments(story_data['kids'])
        }
      end

      def relevant_comments(comment_ids)
        return [] if comment_ids.blank?

        comment_ids.map do |comment_id|
          comment_data = HackerNews::BaseRequest::HnRequestService.new(url: "/item/#{comment_id}.json").call
          parse_comment(comment_data)
        end.compact
      end

      def parse_comment(comment_data)
        return unless comment_data&.dig('type') == 'comment'

        comment_text = clean_comment_text(comment_data['text'] || '')
        return unless comment_text.present?

        if comment_text.split.size > 20
          {
            id: comment_data['id'],
            text: comment_text,
            user: comment_data['by'],
            time: parse_time(comment_data['time'])
          }
        end
      end

      def clean_comment_text(text)
        return unless text.present?

        decoded_text = CGI.unescapeHTML(text)
        cleaned_text = decoded_text.gsub(/<[^>]*>/, '').gsub(/\s+/, ' ').gsub(/[^\w\s]$/, '')

        cleaned_text.strip.presence
      end

      def parse_time(date)
        Time.at(date.to_i).in_time_zone('Brasilia').strftime("%d/%m/%Y %H:%M:%S")
      end
    end
  end
end
