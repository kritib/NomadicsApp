class Travel < ActiveRecord::Base
  attr_accessible :date, :from, :to, :user_id

  belongs_to :traveler, :class_name => "User", :foreign_key => :user_id
end
