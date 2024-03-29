require 'GiphyClient'

module Slack::KudosHelper
  class KudosFormatError < StandardError;
  end
  class LeadersFormatError < StandardError;
  end

  def get_giphy text = ""
    category = kudo_category(text) {|elem| elem.blank? ? "great job" : elem}
    Rails.cache.fetch("get_giphy_#{category}", expires_in: 5.day) {
      GiphyClient::DefaultApi.new.gifs_search_get(ENV["GIPHY_API_KEY"], category, {limit: 25})
    }.data[rand(25)].images.downsized.url
  end

  def kudo_category text
    yield VeeKudos.config[:kudo_categories].select {|elem| text.downcase.include? elem}[0]
  end

  def list_of_receivers p
    raise StandardError unless p[:text].split(" ")[0].to_s.include? "@"
    p[:text].split(" ").select {|e| e.to_s.include? "@"}
  end

  Action = Struct.new(:operation) do
    def === (param)
      case operation
      when "leader"
        ["getter", "giver"].include? param.to_s.downcase
      when "kudo"
        param.to_s.downcase.first.include? "@"
      when "list"
        param.to_s.downcase.eql? "list"
      when "delete"
        param.to_s.downcase.eql? "delete"
      when "all"
        param.to_s.downcase.eql? "all"
      when "ranking"
        param.to_s.downcase.eql? "ranking"
      end
    end
  end

end