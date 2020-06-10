class Kudo < ApplicationRecord

  scope :receiver_leader, -> {group(:receiver).count(:all)}
  scope :sender_leader, -> {group(:sender).count(:all)}
  scope :by_user, -> (getter) {where(receiver: "@#{getter}")}

  def self.parse params
    #First should be the user
    aparams = *params[:text].split(" ")
    raise StandardError unless aparams[0].to_s.include? "@"
    {channel_id: params[:channel_id],
    sender: "@#{params[:user_name]}",
    text: params[:text],
    receiver: aparams[0]}
  end
end
