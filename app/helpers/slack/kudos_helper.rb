require 'GiphyClient'


module Slack::KudosHelper
  class KudosFormatError < StandardError;end
  class LeadersFormatError < StandardError;end

  def self.get_giphy
    instance = GiphyClient::DefaultApi.new
    data = instance.gifs_search_get(ENV["GIPHY_API_KEY"],'thank you',{limit: 1})
    data.data[0].embed_url
  end

end