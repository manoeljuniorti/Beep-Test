require 'httparty'

module HackerNews
  module BaseRequest
    class HnRequestService
      def initialize(url:)
        @base_url = ENV.fetch('BASE_URL').freeze
        @url = url
      end

      def call
        get_request
      rescue StandardError => e
        Rails.logger.error("Erro na requisição para #{@base_url}/#{@url}: #{e.message}")
        puts e.backtrace[0..5]
      end

      private

      def get_request
        response = HTTParty.get("#{@base_url}/#{@url}")
        response.success? ? response.parsed_response : nil
      end
    end
  end
end
