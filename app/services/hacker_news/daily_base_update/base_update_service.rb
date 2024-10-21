module HackerNews
  module DailyBaseUpdate
    class BaseUpdateService
      class << self
        def call(limit)
          fetch_and_save_stories(limit)
          fetch_and_save_comments
        end

        private

        def fetch_and_save_stories(limit)
          story_ids = HackerNews::BaseRequest::HnRequestService.new(url: 'topstories.json').call
          story_ids_to_fetch = story_ids.take(limit)

          existing_stories = Story.where(id: story_ids_to_fetch).pluck(:id)
          new_story_ids = story_ids_to_fetch - existing_stories

          new_story_ids.each do |id|
            story_data = HackerNews::TopNews::StoryDetailsService.new(id).call
            save_story(story_data) if story_data[:id].present?
          end
        end

        def fetch_and_save_comments
          Story.where(created_at: Time.current.beginning_of_day..Time.current.end_of_day).each do |story|
            next if story.id.nil? || story.id.to_s.empty?

            story_data = HackerNews::BaseRequest::HnRequestService.new(url: "item/#{story.id}.json").call
            comment_ids = story_data&.dig('kids')
            comment_ids&.each do |comment_id|
              comment_data = HackerNews::DailyBaseUpdate::CommentDetailService.new(comment_id).call
              save_comment(comment_data, story) if comment_data[:id].present?
            end
          end
        end

        def save_story(story_data)
          return unless story_data.present?

          story = Story.find_or_initialize_by(id: story_data[:id])
          story.assign_attributes(
            title: story_data[:title],
            url: story_data[:url],
            score: story_data[:score],
            created_at: story_data[:time]&.to_i&.then { |time| Time.at(time) } || Time.current
          )
          story.save!
        end

        def save_comment(comment_data, story)
          comment = Comment.find_or_initialize_by(id: comment_data[:id])
          comment.assign_attributes(
            text: comment_data[:text],
            user: comment_data[:by],
            created_at: comment_data[:time]&.to_i&.then { |time| Time.at(time) } || Time.current,
            story: story
          )
          comment.save!
        end
      end
    end
  end
end
