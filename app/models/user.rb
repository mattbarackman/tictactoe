class User < ActiveRecord::Base

  has_many :games_started, :class_name => 'Game', foreign_key: 'player1'
  has_many :games_joined, :class_name => 'Game', foreign_key: 'player2'
  has_many :wins, :class_name => 'Game', foreign_key: 'winner'

  has_secure_password

  validates :name, :presence => true
  validates :email, :presence => true,
                    :uniqueness => true,
                    :format => {:with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i}
  
  validates :password, :presence => true,
                       :on => :create,
                       :length => {:minimum => 5, :maximum => 40}

  def games
    games_started + games_joined
  end

end
