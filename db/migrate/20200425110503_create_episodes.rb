class CreateEpisodes < ActiveRecord::Migration
  def change
    create_table :episodes do |t|
      t.string :title
      t.string :plot
      t.references :season

      t.timestamps
    end
    add_index :episodes, :season_id
  end
end
