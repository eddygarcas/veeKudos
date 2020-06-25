
module Slack::BotHelper
  class Herald
    include HTTParty

    format :json

    def initialize(uri = VeeKudos.config[:slack_api][:base_uri])
      self.class.base_uri uri
    end

    def send_message_to channel_id, text
      pp self.class.base_uri
      response = self.class.post(
          self.class.base_uri + VeeKudos.config[:slack_api][:postMessage],
          headers: {"Authorization" => "Bearer #{ENV[:XOXB_TOKEN.to_s]}"},
          body: {channel: channel_id,text: text})
      pp response
    end

  end
end
