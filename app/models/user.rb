class User < ActiveRecord::Base
  attr_accessible :email, :first_name, :last_name, :photo_blob, 
  								:password, :password_confirmation, :session_token
  has_secure_password

  has_many :travels

  has_many :traveler_relationships, :class_name => "Relationship", 
  				 :foreign_key => :friend_id
  has_many :travelers, :through => :traveler_relationships

  has_many :friend_relationships, :class_name => "Relationship",
  				 :foreign_key => :user_id
  has_many :friends, :through => :friend_relationships

  validates :email

  validates :username, :uniqueness => true, :presence => true
  validates :first_name, :last_name

  validates :password, :length => {:in => 8..16, 
  										 :message => "must be 8-16 characters"},
  										 :format => { :with => /[A-Za-z]\w+\d+/,
  										 :message => "must start with a letter and contain at least one number"},
  										 :presence => true



end
