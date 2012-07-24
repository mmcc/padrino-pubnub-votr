class CreateRounds < ActiveRecord::Migration
  def self.up
    create_table :rounds do |t|
      t.datetime :start_time
      t.datetime :end_time
      t.integer :total_votes, :default => 0
      t.timestamps
    end
  end

  def self.down
    drop_table :rounds
  end
end
