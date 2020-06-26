module Slack::BotHelper
  class Herald
    include HTTParty
    format :json

    attr_reader :xoxb_token

    def xoxb_token(token = nil)
      xoxb_token = token
    end


    def initialize(uri = VeeKudos.config[:slack_api][:base_uri], token = ENV[:XOXB_TOKEN.to_s])
      self.class.base_uri uri
      self.class.xoxb_token token
    end

    def send_message_to channel_id, text
      response = self.class.post(
          VeeKudos.config[:slack_api][:postMessage],
          headers: {Authorization: "Bearer #{xoxb_token}"},
          body: {channel: channel_id,text: text})
      pp response
    end

  end
end
