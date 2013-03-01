class User < ActiveRecord::Base
  attr_accessible :email, :first_name, :last_name, :photo_blob,
  								:password, :password_confirmation, :session_token
  has_secure_password

  has_many :travels
  has_many :requests, :foreign_key => :requester_id

  has_many :traveler_relationships, :class_name => "Relationship",
  				                          :foreign_key => :friend_id
  has_many :travelers, :through => :traveler_relationships

  has_many :friend_relationships, :class_name => "Relationship",
  				                        :foreign_key => :user_id
  has_many :friends, :through => :friend_relationships


  validates :first_name, :last_name, :presence => true
  validates :email, :uniqueness => true, :presence => true
  validates :password, :password_confirmation, :presence => true,
                                               :on => :create

  validates :password, :length => {:in => 8..16,
  										 :message => "must be 8-16 characters"},
  										 :format => { :with => /[A-Za-z]\w+\d+/,
  										 :message => "must start with a letter and contain at least one number"},
                       :allow_blank => true



  def name
    "#{first_name} #{last_name}"
  end

  def reset_token
    token = SecureRandom.hex
    if self.update_attribute(:session_token, token)
      token
    else
      false
    end
  end

  def delete_token
    self.update_attribute(:session_token, nil)
  end

  def get_all_travels
    self.travels.order("date DESC")
  end

  def find_travels(options)
    Travel.create!(options)

  end

  def self.find_users(query_str)
    self
      .select("users.*, (first_name || ' ' || last_name) AS full_name")
      .where("full_name LIKE ?", "\%#{query_str.chomp}\%")
      .all

  end

  def find_friend_travels(query)
    self.travelers
        .joins(:travels)
        .where("travels.from = ? AND travels.to = ? AND travels.date >= ?",
               query[:from], query[:to], Date.today)
        .order("ABS(travels.date - ?)", query[:date])

    self.travelers
        .includes(:travels)

  end


end
