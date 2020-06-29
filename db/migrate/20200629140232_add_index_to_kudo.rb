class AddIndexToKudo < ActiveRecord::Migration[6.0]
  def change
    add_index :kudos, :team_id
  end
end
