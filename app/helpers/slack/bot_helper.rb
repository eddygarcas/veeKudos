module Slack::BotHelper
  class Herald
    include HTTParty

    attr_reader :xoxb_token

    format :json
    xoxb_token ENV[:XOXB_TOKEN.to_s]

    def initialize(uri = VeeKudos.config[:slack_api][:base_uri])
      self.class.base_uri uri
    end

    def send_message_to channel_id, text
      response = self.class.post(
          VeeKudos.config[:slack_api][:postMessage],
          headers: {"Authorization" => "Bearer #{xoxb_token}"},
          body: {channel: channel_id,text: text})
      pp response
    end

  end
end
