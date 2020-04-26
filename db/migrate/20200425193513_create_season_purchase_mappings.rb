class CreateSeasonPurchaseMappings < ActiveRecord::Migration
  def change
    create_table :season_purchase_mappings do |t|
      t.belongs_to :season
      t.belongs_to :library
      t.datetime :purchase_time
      t.timestamps
    end
  end
end
