class Kudo < ApplicationRecord

  scope :getter_leader, -> (id) {where(team_id: id).group(:receiver).count(:all)}
  scope :giver_leader, -> (id) {where(team_id: id).group(:sender).count(:all)}
  scope :by_user, -> (getter) {where(receiver: "@#{getter}")}

  def self.create_set params
    to = params[:text].split(" ").select {|e| e.to_s.include? "@"}
    Kudo.transaction do
      to.each {|r| Kudo.create(parse(params, r))}
    end
    to
  end

  def self.parse p, r = nil
    aparams = *p[:text].split(" ")
    {channel_id: p[:channel_id],
     channel_name: p[:channel_name],
     team_id: p[:team_id],
     team_name: p[:team_domain],
     sender: "@#{p[:user_name]}",
     text: p[:text].html_safe,
     receiver: r.blank? ? aparams[0] : r}
  end
end
