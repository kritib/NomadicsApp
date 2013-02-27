class Travel < ActiveRecord::Base
  # REV: looks kind of weird to have blank line after class def.

  attr_accessible :date, :from, :to, :user_id

  # REV: I'd put all the associations more tightly together
  belongs_to :traveler, :class_name => "User", :foreign_key => :user_id

  belongs_to :from_country, :class_name => "Country", :foreign_key => :from

  belongs_to :to_country, :class_name => "Country", :foreign_key => :to

  validates :date, :from, :to, :user_id, :presence => true
end
