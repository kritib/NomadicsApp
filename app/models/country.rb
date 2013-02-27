class Country < ActiveRecord::Base
  attr_accessible :name, :x, :y

  # REV: validations?
end
