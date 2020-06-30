
class Slack::KudosController < ApplicationController
  include Slack::KudosHelper
  include Slack::BotHelper

  skip_before_action :verify_authenticity_token
  before_action :set_command
  before_action :verify_slack_request


  def create
    case @commands[0]
    when Action.new("list")
      return_kudos_list
      render 'slack/kudos/my_kudos' and return
    when Action.new("leader")
      leader_list @commands[0].to_s.downcase
      render 'slack/kudos/leaders' and return
    when Action.new("kudo")
      make_a_kudo
      render 'slack/kudos/create' and return
    when Action.new("delete")
      delete_my_kudos
      render 'slack/kudos/my_kudos' and return
    when Action.new("all")
      @kudos = Kudo.all
      render 'slack/kudos/my_kudos' and return
    end
    raise KudosFormatError
  end

  protected

  def leader_list command
    case command
    when "getter"
      @kudos = Kudo.getter_leader(params[:team_id]).sort_by {|_k, v| v}.reverse
    when "giver"
      @kudos = Kudo.giver_leader(params[:team_id]).sort_by {|_k, v| v}.reverse
    end
  end

  def make_a_kudo
    @kudo = Kudo.create(Kudo.parse params)
    @image = Slack::KudosHelper.get_giphy params[:text]
    Herald.new(VeeKudos.config[:web_hooks][:base_uri]).
        send_to_webhook(Slack::KudosController.render(:plain, assigns: {kudo: @kudo}))
  end

  def return_kudos_list
    @kudos = Kudo.by_user params[:user_name]
  end

  def delete_my_kudos
    Kudo.by_user(params[:user_name]).delete_all
    @kudos = Kudo.by_user params[:user_name]
  end

  private

  #Commands will contains and array from the text introduced by the sender https://api.slack.com/interactivity/slash-commands
  def set_command
    @commands = *params[:text].split(" ")
  end

  def verify_slack_request
    timestamp = request.headers['X-Slack-Request-Timestamp']
    if (Time.now.to_i - timestamp.to_i).abs > 60 * 5
      head :unauthorized
      return
    end

    sig_basestring  = "v0:#{timestamp}:#{request.raw_post}"
    signature       = "v0=" + OpenSSL::HMAC.hexdigest("SHA256", Rails.application.credentials.slack_signing_secret, sig_basestring)
    slack_signature = request.headers['X-Slack-Signature']

    if !ActiveSupport::SecurityUtils.secure_compare(signature, slack_signature)
      head :unauthorized
    end
  end

end
