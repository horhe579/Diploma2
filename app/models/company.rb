class Company < ApplicationRecord
    has_many :users 
    has_many :cards

    validates :name, presence: true
end
