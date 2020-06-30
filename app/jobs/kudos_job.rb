require '../../app/helpers/slack/bot_helper'
class KudosJob < ApplicationJob
  queue_as :default

  def perform(*args)
    @kudos = Kudo.getter_leader(params[:team_id]).sort_by {|_k, v| v}.reverse
    Herald.new(VeeKudos.config[:web_hooks][:base_uri]).send_to_webhook(Slack::KudosController.render 'slack/kudos/leaders')
  end
end
