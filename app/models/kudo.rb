class Kudo < ApplicationRecord
  belongs_to :workspace

  scope :receiver_leader, -> {group(:receiver).count(:all)}
  scope :sender_leader, -> {group(:sender).count(:all)}
  scope :by_user, -> (getter) {where(receiver: "@#{getter}")}

  def self.parse params
    aparams = *params[:text].split(" ")
    raise StandardError unless aparams[0].to_s.include? "@"
    {channel_id: params[:channel_id],
     channel_name: params[:channel_name],
     team_id: params[:team_id],
     team_name: params[:team_domain],
    sender: "@#{params[:user_name]}",
    text: params[:text],
    receiver: aparams[0]}
  end
end
