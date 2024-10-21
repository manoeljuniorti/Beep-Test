module HackerNews
  module Search
    class SearchService
      def initialize(params:)
        @query = params[:query].downcase
        @page = params[:page] || 1
        @per_page = params[:per_page] || 10
      end

      def call
        query_process
      end

      private

      def query_process
        results = search_results
        paginated_results = paginate(results)

        {
          pagination: pagination_info(paginated_results),
          result: {
            stories: paginated_results.select { |r| r.is_a?(Story) },
            comments: paginated_results.flat_map(&:comments).select { |c| c.is_a?(Comment) }
          }
        }
      end

      def search_results
        Story.joins(:comments)
          .where("lower(stories.title) LIKE :query OR lower(stories.url) LIKE :query OR lower(comments.text) LIKE :query", query: "%#{@query}%")
          .order(created_at: :desc)
      end

      def paginate(scope)
        scope.page(@page).per(@per_page)
      end

      def pagination_info(paginated_data)
        {
          current_page: paginated_data.current_page,
          next_page: paginated_data.next_page,
          previous_page: paginated_data.prev_page,
          total_pages: paginated_data.total_pages,
          total_count: paginated_data.total_count
        }
      end
    end
  end
end
