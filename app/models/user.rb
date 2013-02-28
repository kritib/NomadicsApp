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

  def find_travels(options)
    Travel.create!(options)

  end

  def self.find_users(query_str)
    self
      .select("users.*, (first_name || ' ' || last_name) AS full_name")
      .where("full_name LIKE ?", "\%#{query_str.chomp}\%")
      .all

  end

  # def search_results(queries)
  #   queries = parse_queries(queries)
  #   friend_results = []
  #   friends = self.travelers
  #   results = []

  #   queries.each do |query|
  #     results += User.select("('first_name' || ' ' || 'last_name') AS full_name")
  #                     .where("full_name LIKE ?", query)
  #   end

  #   results = User.all.where("first_name LIKE ? OR last_name IN ? OR email IN ?",
  #                            queries, queries, queries)
  #   results.uniq!.each do |result|
  #     if friends.include?(result)
  #       friend_results.push(results.delete(result))
  #     end
  #   end



  # end

  def parse_queries(query_str)
    query_str.split(' ').map do |query|
      "\%#{query}\%"
    end
  end


end
