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

  property :password, BCryptHash, :required => true
  validates_confirmation_of :password

  attr_accessor :password_confirmation
  validates_length_of :password_confirmation, :min => 6, :if => :new_user

  def new_user
    self.new?
  end

  has n, :memberships
  has n, :groups, through: :memberships

  has n, :created_bets, 'Bet', :child_key => [:bettor_id]
  has n, :received_bets, 'Bet', :child_key => [:bettee_id]

  def join_bets
    self.created_bets + self.received_bets
  end


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
  has n, :bets

end

# BETS
# =====================================

class Bet
  include DataMapper::Resource
  property :id, Serial
  property :amount, Float
  property :expiration, Date
  property :description, Text

  belongs_to :bettor, 'User', :key => true
  belongs_to :bettee, 'User', :key => true
  belongs_to :group
end

DataMapper.finalize
DataMapper.auto_upgrade!
