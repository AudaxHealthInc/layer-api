require "layer/api/client/conversations"
require "layer/api/client/announcements"
require "layer/api/client/users"
require "layer/api/client/identity_token"

module Layer
  module Api
    class Client
      include Layer::Api::Conversations
      include Layer::Api::Announcements
      include Layer::Api::Users

      attr_accessor :api_token, :app_id

      def initialize(options = {})
        @api_token = options[:api_token] || ENV['LAYER_API_TOKEN']
        @app_id = options[:app_id] || ENV['LAYER_APP_ID']
        strip_layer_prefix(@app_id)
      end

      def client
        @http_client ||= HttpClient.new(app_id, api_token)
      end

      def get(url, *args)
        client.get(url, *args)
      end

      def post(url, *args)
        client.post(url, *args)
      end

      def put(url, *args)
        client.put(url, *args)
      end

      def patch(url, *args)
        client.patch(url, *args)
      end

      def delete(url)
        client.delete(url)
      end

      def strip_layer_prefix(string)
        string.split("/").last if string
      end
    end
  end
end
