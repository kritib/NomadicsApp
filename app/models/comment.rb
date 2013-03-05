class Comment < ActiveRecord::Base
  attr_accessible :body, :commenter_id, :request_id, :travel_id

  belongs_to :travel
  belongs_to :commenter, :class_name => "User",
                         :foreign_key => :commenter_id


  validates :travel_id, :commenter_id, :body, :presence => true
end
