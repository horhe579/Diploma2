class User < ApplicationRecord
  has_one :game
  #after_create :create_player

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable

  belongs_to :company
  

end

#  devise :database_authenticatable, :registerable,
#:recoverable, :rememberable, :validatable
