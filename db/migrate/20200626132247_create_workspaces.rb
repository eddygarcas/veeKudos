class CreateWorkspaces < ActiveRecord::Migration[6.0]
  def change
    create_table :workspaces do |t|
      t.string :team_domain
      t.string :team_id
      t.string :enterprise_id
      t.string :enterprise_name
      t.string :icon
      t.timestamps
    end
  end
end
