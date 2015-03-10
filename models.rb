require 'data_mapper'
require 'bcrypt'

if ENV['RACK_ENV'] != 'production'
  require 'dotenv'
  Dotenv.load('.env')
end

DataMapper.setup(:default, ENV['DATABASE_URL'])

# USERS
# =====================================

class User
  include DataMapper::Resource
  property :id, Serial
  property :first_name, String, :required => true
  property :last_name, String, :required => true
  property :email, String, { :required => true,
                             :unique => true,
                             :format => :email_address,
                             :messages => { :presence  => "Please enter a valid email address.",
                                            :is_unique => "It looks like that email is already taken.",
                                            :format    => "Please enter a valid email address"
                                          }
                            }
  property :phone_number, String, { :required => true,
                                     :unique => true,
                                     :messages => { :presence => "Please enter your phone number.",
                                                    :is_unique => "It looks like that phone number is taken."
                                                  }
                                  }

  property :password, BCryptHash, :required => true
  validates_confirmation_of :password

  attr_accessor :password_confirmation
  validates_length_of :password_confirmation, :min => 6, :if => :new_user

  def new_user
    self.new?
  end

  has n, :memberships
  has n, :groups, through: :memberships

  has 1, :bet, :child_key => [:bet_creator_id]
  has 1, :bet, :child_key => [:bet_receiver_id]

end

# MEMBERSHIP JOIN TABLE
# =====================================

class Membership
  include DataMapper::Resource
  property :id, Serial
  belongs_to :user, :required => true
  belongs_to :group, :required => true

end

# GROUPS
# =====================================

class Group
  include DataMapper::Resource
  property :id, Serial
  property :group_name, String, { :required => true,
                                   :unique => true,
                                   :messages => { :is_unique => "Group name is taken. Please choose another." }
                                  }

  property :password, BCryptHash, :required => true
  validates_confirmation_of :password

  attr_accessor :password_confirmation
  validates_length_of :password_confirmation, :min => 6, :if => :new_group


  def new_group
    self.new?
  end

  has n, :memberships
  has n, :users, through: :memberships

end

# BETS
# =====================================

class Bet
  include DataMapper::Resource
  property :id, Serial
  property :amount, Float
  property :expiration, Date

  belongs_to :bet_creator, 'User'
  belongs_to :bet_receiver, 'User'

end

DataMapper.finalize
DataMapper.auto_upgrade!
