class GamesUser < ApplicationRecord
    validates :user_id, presence: true, uniqueness: { scope: :game_id, message: "already has joined this game"}

    validates :game_id, presence: true

    validates :company_id, presence: true

    belongs_to :user
    belongs_to :game
    belongs_to :company

    #validate uniqueness of za da ne moje da joinva edin user 2 puti
    #kakto i da se pokazva formata samo ako ne si v dadenata igra
  
end
