class Workspace < ApplicationRecord
  has_many :kudos, dependent: :destroy

  def self.create params
    Workspace.where(team_id: params[:team_id]).
        first_or_create(Workspace.parse(params).
            update(Workspace.parse(params)))
  end

  def self.parse params
    {team_domain: params[:team_domain],
     team_id: params[:team_id]}
  end
end
