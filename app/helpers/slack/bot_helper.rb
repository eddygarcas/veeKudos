require 'httparty'

module Slack::BotHelper
  class Herald
    include HTTParty

    format :json

    def initialize(base_uri = VeeKudos.config[:slack_api][:base_uri])
      self.class.base_uri = base_uri
    end

    def send_message_to channel_id, text
      response = self.class.post(
          VeeKudos.config[:slack_api][:postMessage],
          headers: {"Authorization" => "Bearer #{ENV[:XOXB_TOKEN.to_s]}"},
          body: {channel: channel_id,text: text})
    end

  end
end
