class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception
  before_action :set_default_format

  rescue_from Slack::KudosHelper::KudosFormatError,with: :rescue_400
  rescue_from Slack::KudosHelper::LeadersFormatError,with: :rescue_400_leaders

  def rescue_400_leaders
    render json: {text: "*🤖 Ups!* Something went wrong, try again using the following format `/leaders [getters | givers]`"}
  end
  def rescue_400
    render json: {text: "*🤖 Ups!* Something went wrong, try again using one of the following commands\n `/kudos @username text` - Give Kudos to a colleague\n `/kudos ranking` - See Kudos leader board\n `/kudos list` - List your Kudos\n `/kudos delete` - Delete your Kudos"}
  end

  private

  def set_default_format
    request.format = :json
  end
end
