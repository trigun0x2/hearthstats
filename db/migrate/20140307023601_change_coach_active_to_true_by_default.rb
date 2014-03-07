class ChangeCoachActiveToTrueByDefault < ActiveRecord::Migration
  def up
    change_column :coaches, :active, :boolean, :default => true
  end

  def down
  end
end
