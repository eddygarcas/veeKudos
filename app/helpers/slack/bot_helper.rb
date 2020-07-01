module Slack::BotHelper
  class Herald
    include HTTParty
    attr_accessor :xoxb_token

    format :json

    def initialize(uri = VeeKudos.config[:slack_api][:base_uri], token = ENV[:XOXB_TOKEN.to_s])
      self.class.base_uri uri
      self.xoxb_token =  token
    end

    def send_message_to text, channel_id = nil
      self.class.post(
          VeeKudos.config[:slack_api][:postMessage],
          headers: {Authorization: "Bearer #{xoxb_token}"},
          body: {channel: channel_id,text: text}) unless channel_id.blank?

      self.class.post(
          Rails.application.credentials.web_hook_secret,
          body: text) unless channel_id.present?
    end

  end
end
