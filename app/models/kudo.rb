class Kudo < ApplicationRecord

  scope :getter_leader, -> (id) {where(team_id: id).group(:receiver).count(:all)}
  scope :giver_leader, -> (id) {where(team_id: id).group(:sender).count(:all)}
  scope :by_user, -> (getter) {where(receiver: "@#{getter}")}

  def self.create_set params,to
    Kudo.transaction do
      to.each { |r| Kudo.create(parse(params,r)) }
    end
  end


  def self.parse params, reciver = nil
    aparams = *params[:text].split(" ")
    {channel_id: params[:channel_id],
     channel_name: params[:channel_name],
     team_id: params[:team_id],
     team_name: params[:team_domain],
    sender: "@#{params[:user_name]}",
    text: params[:text],
    receiver: reciver.blank? ? aparams[0] : reciver}
  end
end
