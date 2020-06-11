class Slack::KudosController < ApplicationController
  include Slack::KudosHelper
  skip_before_action :verify_authenticity_token
  before_action :set_command
  before_action :verify_slack_request

  def create
    redirect_to kudos_my_kudos_path unless @commands[0].to_s.include? "@"
    @kudo = Kudo.create(Kudo.parse params)
  end

  def leaders
    raise LeadersFormatError unless ["getter","giver","all"].include? @commands[0].to_s.downcase
    case @commands[0].to_s.downcase
    when "getter"
      @kudos = Kudo.receiver_leader.sort_by {|_k, v| v}.reverse
    when "giver"
      @kudos = Kudo.sender_leader.sort_by {|_k, v| v}.reverse
    end
  end

  def my_kudos
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
