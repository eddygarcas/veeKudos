
module Slack::BotHelper
  class Herald
    include HTTParty

    format :json

    def initialize(uri = VeeKudos.config[:slack_api][:base_uri])
      pp uri
      self.base_uri uri
    end

    def send_message_to channel_id, text
      response = self.class.post(
          "chat.postMessage",
          headers: {"Authorization" => "Bearer #{ENV[:XOXB_TOKEN.to_s]}"},
          body: {channel: channel_id,text: text})
      pp response
    end

  end
end
