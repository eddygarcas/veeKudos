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
  def self.get_giphy text = "great job"
    instance = GiphyClient::DefaultApi.new
    data = instance.gifs_search_get(ENV["GIPHY_API_KEY"],kudo_category(text),{limit: 25})
    data.data[rand(25)].images.downsized.url
  end

  def self.kudo_category text
    pp text
    adj = ["awesome","well done","proud","great job","congratulation","thanks"].map {|elem| text.downcase.include? elem }
    pp adj
    adj[0]
  end

end