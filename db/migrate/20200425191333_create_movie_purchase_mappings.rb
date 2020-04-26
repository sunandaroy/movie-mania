class CreateMoviePurchaseMappings < ActiveRecord::Migration
  def change
    create_table :movie_purchase_mappings do |t|
      t.belongs_to :movie
      t.belongs_to :library
      t.datetime :purchase_time
      t.timestamps
    end
  end
end
