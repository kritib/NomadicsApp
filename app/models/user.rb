class User < ActiveRecord::Base
  attr_accessible :email, :first_name, :last_name, :photo_blob,
  								:password, :password_confirmation, :session_token
  has_secure_password

  has_many :travels
  has_many :requests, :foreign_key => :requester_id
  has_many :mulings, :class_name => "Request", :foreign_key => :mule_id

  has_many :traveler_relationships, :class_name => "Relationship",
  				                          :foreign_key => :friend_id
  has_many :travelers, :through => :traveler_relationships
  has_many :traveler_travels, :through => :travelers, :source => :travels

  has_many :friend_relationships, :class_name => "Relationship",
  				                        :foreign_key => :user_id
  has_many :friends, :through => :friend_relationships
  has_many :friend_mule_requests, :through => :friends, :source => :requests


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

  def travels_by_origin
    self.travels
        .joins(:from_country)
        .order("countries.name")
  end

  def travels_by_destination
    self.travels
        .joins(:to_country)
        .order("countries.name")
  end

  def travels_by_updated
    self.travels
        .order("updated_at DESC")
  end

  def travels_by_travel_date
    self.travels
        .order("date DESC")
  end

  def find_travels(options)
    Travel.create!(options)

  end

  def self.find_users(query_str)
    self
      .where("(first_name || ' ' || last_name) LIKE ?",
             "\%#{query_str.chomp}\%")
      .all

  end

  def all_friend_travels
    self.traveler_travels("updated_at DESC")
  end

  def all_friend_mule_requests
    self.friend_mule_requests.order("updated_at DESC")
  end

  def find_friend_travels(query)
    order_str = User.send(:sanitize_sql_array,
                          ["ABS(travels.date - ?)", query[:date]])
    select_str = User.send(:sanitize_sql_array,
                          ["travels.*, (travels.date - ?) AS time_diff", query[:date]])
    self.traveler_travels
        .select(select_str)
        .where("travels.from = ? AND
                travels.to = ? AND
                travels.date >= ?",
                query[:from], query[:to], Date.today)
        .order(order_str)
  end


end
