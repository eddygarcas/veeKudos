class AddWorkspaceRefToKudos < ActiveRecord::Migration[6.0]
  def change
    add_reference :kudos, :workspace, null: false, foreign_key: true
  end
end
