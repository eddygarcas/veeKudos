class AddTeamNameToKudo < ActiveRecord::Migration[6.0]
  def change
    add_column :kudos, :team_name, :string
    add_column :kudos, :team_id, :string
  end
end
