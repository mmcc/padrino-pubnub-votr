class ChangePercentageToFloat < ActiveRecord::Migration
  def self.up
  	change_column :songs, :percentage, :float, :default => 0
  end

  def self.down
  	change_column :songs, :percentage, :integer, :default => 0
  end
end
