class GamesUser < ApplicationRecord
    validates :user_id, presence: true, uniqueness: { scope: :game_id, message: "already has joined this game"}

    validates :game_id, presence: true

    validates :company_id, presence: true

    belongs_to :user
    belongs_to :game
    belongs_to :company

    after_initialize :set_defaults
    after_create :setup_game


    #validate uniqueness of za da ne moje da joinva edin user 2 puti
    #kakto i da se pokazva formata samo ako ne si v dadenata igra

    private

    def setup_game
        if game.games_users.count == 4
            game.games_users.each do |player|
                3.times do
                    card = player.company.cards.where.not(id: Dealt.where(games_user: player).pluck(:card_id)).sample #no method dealts
                    Dealt.create(games_user: player, card: card)
                end
            end
        end   

    end

    def set_defaults
        self.hp = 10
        self.shield = 0
    end
  
end
