class Travel < ActiveRecord::Base
	COUNTRIES =  ["America",
								"England",
								"India"]

  attr_accessible :date, :from, :to, :user_id

  belongs_to :traveler, :class_name => "User", :foreign_key => :user_id

  validates :date, :from, :to, :user_id, :presence => true
end
