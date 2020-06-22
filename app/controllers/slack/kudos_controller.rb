
class Slack::KudosController < ApplicationController
  include Slack::KudosHelper
  skip_before_action :verify_authenticity_token
  before_action :set_command

  before_action :verify_slack_request

  Action = Struct.new(:operation) do
    def === (param)
      case operation
      when "leader"
        ["getter","giver"].include? param.to_s.downcase
      when "kudo"
        param.to_s.downcase.include? "@"
      when "list"
        param.blank?
      end
    end
  end

  def create
    case @commands[0]
    when Action.new("list")
      return_kudos_list
      render 'slack/kudos/my_kudos'
    when Action.new("leader")
      leader_list @commands[0].to_s.downcase
      render 'slack/kudos/leaders'
    when Action.new("kudo")
      make_a_kudo
      render 'slack/kudos/create'
    end
  end

  def leaders
    #raise KudosFormatError unless ["getter","giver","all","@"].include? @commands[0].to_s.downcase unless @commands.empty?
  end

  protected

  def leader_list command
    case command
    when "getter"
      @kudos = Kudo.receiver_leader.sort_by {|_k, v| v}.reverse
    when "giver"
      @kudos = Kudo.sender_leader.sort_by {|_k, v| v}.reverse
    end
  end

  def make_a_kudo
    @kudo = Kudo.create(Kudo.parse params)
    @image = Slack::KudosHelper.get_giphy params[:text]
  end

  def return_kudos_list
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
