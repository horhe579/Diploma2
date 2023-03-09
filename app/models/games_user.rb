class GamesUser < ApplicationRecord
    validates :user_id, presence: true, uniqueness: { scope: :game_id, message: "already has joined this game"}

    validates :game_id, presence: true

    validates :company_id, presence: true

    belongs_to :user
    belongs_to :game
    belongs_to :company

    #after_initialize :set_defaults
    after_create :setup_game

    delegate :username, to: :user


    #validate uniqueness of za da ne moje da joinva edin user 2 puti
    #kakto i da se pokazva formata samo ako ne si v dadenata igra

    def in_hand
        played_card_ids = Turn.where(games_user_id: id).pluck(:card_id)
        drawn_card_ids = Dealt.where(games_user_id: id).pluck(:card_id)
        drawn_cards = Card.where(id: drawn_card_ids)
        played_cards = Card.where(id: played_card_ids)
      
        cards_in_hand = drawn_cards - played_cards
        cards_in_hand.pluck(:id)
    end

    def is_current_turn?
        players = GamesUser.where(game_id: self.game_id, completed_at: nil).order(:created_at).to_a
        my_position = players.index(self)
        previous_player_id = players[(my_position - 1) % players.count].id

        last_turn = Turn.joins(:games_user).where(games_users: { game_id: self.game_id }).last
        last_dealt = Dealt.joins(:games_user).where(games_users: { game_id: self.game_id }).last

        if last_turn.nil? 
            #v nachaloto na igrata nqma playove, rezultatut se opredelq sprqmo koi e vlqzul purvi
            if last_dealt.games_user_id == previous_player_id
                return players[0].id == self.id
            else
                return false
            end
        elsif last_turn.games_user_id == previous_player_id && last_dealt.games_user_id == previous_player_id
            #ako posledniq hod e na igracha predi men znachi sega e moi red
            return true
        else
            return false
        end

        #dovurshi
    end

    def check_end_game
        if hp <= 0
            update(completed_at: Time.zone.now)   
        end

        remaining_players = GamesUser.where(game_id: self.game_id, completed_at: nil)
        if remaining_players.count == 1
            remaining_players.last.update(completed_at: Time.zone.now)
        end
    end


    #metod za sravnenie na hpto i shtita


    #is current turn, opredelq dali v momenta e red na segashniq igrach
    private

    def setup_game
        if game.games_users.count == 4
            game.games_users.order(:created_at).each do |player|
                3.times do
                    card = player.company.cards.where.not(id: Dealt.where(games_user: player).pluck(:card_id)).sample #no method dealts
                    Dealt.create(games_user: player, card: card)
                end
            end
        end   

    end

    # def set_defaults
    #     self.hp = 10
    #     self.shield = 0
    # end
  
end
