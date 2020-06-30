class KudosJob < ApplicationJob
  include Slack::BotHelper

  queue_as :default

  def perform(*args)
    @kudos = Kudo.getter_leader("T0F48V7E2").sort_by {|_k, v| v}.reverse
    Herald.new(VeeKudos.config[:web_hooks][:base_uri]).
        send_to_webhook(Slack::KudosController.render(:leaders, assigns: {commands: "", kudos: @kudos}))
  end
end
