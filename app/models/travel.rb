class Travel < ActiveRecord::Base

  attr_accessible :date, :from, :to, :user_id

  belongs_to :traveler, :class_name => "User", :foreign_key => :user_id
  belongs_to :from_country, :class_name => "Country", :foreign_key => :from
  belongs_to :to_country, :class_name => "Country", :foreign_key => :to

  has_many :shippings
  has_many :comments

  validates :date, :from, :to, :user_id, :presence => true

  validates :date, :uniqueness => { :scope => [:from, :to],
                   :message => "You've already entered this trip" }
end
