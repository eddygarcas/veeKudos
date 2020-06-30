require_relative '../../app/helpers/slack/bot_helper'
class KudosJob < ApplicationJob
  queue_as :default

  def perform(*args)
    @commands = []
    @commands[0] = ""
    @kudos = Kudo.getter_leader("T0F48V7E2").sort_by {|_k, v| v}.reverse
    Herald.new(VeeKudos.config[:web_hooks][:base_uri]).
        send_to_webhook(Slack::KudosController.render(:leaders, assigns: {commands: @commands, kudos: @kudo}))
  end
end
