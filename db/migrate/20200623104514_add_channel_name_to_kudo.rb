class AddChannelNameToKudo < ActiveRecord::Migration[6.0]
  def change
    add_column :kudos, :channel_name, :string
  end
end
