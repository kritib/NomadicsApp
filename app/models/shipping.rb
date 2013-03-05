class Shipping < ActiveRecord::Base
  attr_accessible :request_id, :travel_id

  belongs_to :request
  belongs_to :travel
  belongs_to :shipper, :through => :travel, :source => :traveler


  validates :request_id, :travel_id, :presence => true
  validates :request_id, :uniqueness => true
end
