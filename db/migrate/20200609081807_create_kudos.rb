class CreateKudos < ActiveRecord::Migration[6.0]
  def change
    create_table :kudos do |t|
      t.string :sender
      t.string :text
      t.string :receiver
      t.string :channel_id

      t.timestamps
    end
  end
end
