class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception
  before_action :set_default_format

  rescue_from Slack::KudosHelper::KudosFormatError,with: :rescue_400
  rescue_from Slack::KudosHelper::LeadersFormatError,with: :rescue_400_leaders

  def rescue_400_leaders
    render json: {text: "*🤖 Ups!* Something went wrong, try again using the following format `/leaders [getters | givers]`"}
  end
  def rescue_400
    render json: {text: "*🤖 Ups!* Something went wrong, try again using the following format\n `/kudos @username text` give Kudos\n `/kudos [getter | giver]` Kudos leader board\n `/kudos list` list your Kudos\n `/kudos delete` delete your Kudos"}
  end

  private

  def set_default_format
    request.format = :json
  end
end
