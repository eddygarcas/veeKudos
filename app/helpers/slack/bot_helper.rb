module Slack::BotHelper
  class Herald
    include HTTParty
    attr_accessor :xoxb_token

    format :json

    def initialize(uri = VeeKudos.config[:slack_api][:base_uri], token = ENV[:XOXB_TOKEN.to_s])
      self.class.base_uri uri
      self.xoxb_token =  token
    end

    def send_message_to channel_id, text
      response = self.class.post(
          VeeKudos.config[:slack_api][:postMessage],
          headers: {Authorization: "Bearer #{xoxb_token}"},
          body: {channel: channel_id,text: text})
      pp response
    end

    def send_to_webhook text
      message =  '{"text":"' + text + '"}'
      self.class.post(
          VeeKudos.config[:web_hooks][:channel],
          body: message)
    end

  end
end
