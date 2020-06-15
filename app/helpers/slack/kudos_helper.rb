require 'GiphyClient'


module Slack::KudosHelper
  class KudosFormatError < StandardError;end
  class LeadersFormatError < StandardError;end

  # awesome
  # well done
  # proud
  # happy
  # great job
  # congratulations
  # many thanks
  def self.get_giphy
    instance = GiphyClient::DefaultApi.new
    data = instance.gifs_search_get(ENV["GIPHY_API_KEY"],'great job',{limit: 25})
    data.data[rand(25)].images.downsized.url
  end

end