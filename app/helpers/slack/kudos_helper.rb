require 'GiphyClient'


module Slack::KudosHelper
  class KudosFormatError < StandardError;end
  class LeadersFormatError < StandardError;end

  def self.get_giphy text = "great job"
    instance = GiphyClient::DefaultApi.new
    data = instance.gifs_search_get(ENV["GIPHY_API_KEY"],kudo_category(text),{limit: 25})
    data.data[rand(25)].images.downsized.url
  end

  def self.kudo_category text
    VeeKudos.config[:kudo_categories].select {|elem| text.downcase.include? elem }[0]
  end

end