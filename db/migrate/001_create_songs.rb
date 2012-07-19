class CreateSongs < ActiveRecord::Migration
  def self.up
    create_table :songs do |t|
      t.string :title
      t.string :artist
      t.integer :votes, :default => 0
      t.decimal :percentage
      t.integer :round_id
      t.timestamps
    end
  end

  def self.down
    drop_table :songs
  end
end
