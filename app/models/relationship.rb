class Relationship < ActiveRecord::Base
  attr_accessible :friend_id, :user_id

  belongs_to :traveler, :class_name => "User", :foreign_key => :user_id
  belongs_to :friend, :class_name => "User", :foreign_key => :friend_id
end
