class CoachesTable < ActiveRecord::Migration
  def change
    create_table :coaches do |t|
      t.integer :user_id
      t.text :description
      t.text :available
      t.boolean :active

      t.timestamps
    end
  end
end
