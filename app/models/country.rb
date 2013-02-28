class Country < ActiveRecord::Base
  attr_accessible :name, :x, :y

  validates :name, :presence => true, :uniqueness => true

end
