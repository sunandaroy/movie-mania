class CreateLibraries < ActiveRecord::Migration
  def change
    create_table :libraries do |t|
      t.timestamps
      t.belongs_to :user
    end
  end
end
