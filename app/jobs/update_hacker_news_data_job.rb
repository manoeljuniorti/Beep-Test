class UpdateHackerNewsDataJob < ApplicationJob
  queue_as :base_update_queue

  def perform(limit: 100)
    HackerNews::DailyBaseUpdate::BaseUpdateService.call(limit)
  end
end
