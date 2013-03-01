class Request < ActiveRecord::Base
  attr_accessible :requester_id, :date, :from, :to, :mule_id,
                  :item_description, :item_legality, :item_size, :item_weight

  belongs_to :requester, :class_name => "User", :foreign_key => :requester_id
  belongs_to :from_country, :class_name => "Country", :foreign_key => :from
  belongs_to :to_country, :class_name => "Country", :foreign_key => :to
  belongs_to :mule, :class_name => "User", :foreign_key => :mule_id


  validates :requester_id, :date, :from, :to, :presence => true
  validates :item_size, :inclusion => { :in => %w(small medium large)}
end