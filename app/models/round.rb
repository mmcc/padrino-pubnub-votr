class Round < ActiveRecord::Base

	has_many :songs

	scope :current, lambda { 
    where("start_time >= ? and end_time > ?", DateTime.now, DateTime.now)
  }
	
end
