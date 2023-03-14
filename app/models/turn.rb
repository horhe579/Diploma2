class Turn < ApplicationRecord
  validates :games_user_id, presence: true, uniqueness: { scope: :card_id }
  validates :card_id, presence: true

  belongs_to :games_user
  belongs_to :card
  belongs_to :damaged_games_user, optional: true, class_name: "GamesUser"
  belongs_to :healed_games_user, optional: true, class_name: "GamesUser"
  belongs_to :shielded_games_user, optional: true, class_name: "GamesUser"


  after_save :apply_card_stats
  after_create_commit do 
    #puts "blvlallv"
    #logika v broadcasta, ako e tekusht red broadcast prazno
    players = GamesUser.where(game_id: self.games_user.game_id, completed_at: nil).order(:created_at).to_a
    my_position = players.index(self.games_user)
    next_user = players[(my_position + 1) % players.count]
    if next_user.is_current_turn?
      broadcast_replace_later_to(
        #self.games_user.user, 
        self.games_user.game,
        target: "draw_card_frame_for_user_#{next_user.user.id}",
        partial: "dealts/form", locals: { dealt: Dealt.find_by(games_user_id: self.games_user_id, card_id: self.card_id), current_user: self.games_user.user }

      )
    else
      all_the_other_players = GamesUser.where(game_id: self.games_user.game).where.not(user_id: next_user.id)
      all_the_other_players.each do |games_user| 
        broadcast_replace_later_to(
          #self.games_user.user, 
          self.games_user.game,
          target: "draw_card_frame_for_user_#{games_user.user.id}",
          partial: "dealts/empty"

        )
      end
    end  
  #   #kogato broadcastvam she vidq che se broadcastva kum imeto na streama, koeto chesto ne e svurzano s potrebiteql
  #   #za da moje da streamvam kum konkreten potrebitel trqbva da moga da suzdam kanali, koito sa svurzani s imenata na potrebitelq i broadcasta da go poema tva
  #   #tuk shte imam logika za pisane, koqto vklyuchva potrebitelq
  #   #cheta dokumentaciqta
    #2-3 primera kak se izpolzva
  end

  def apply_card_stats
    card = Card.find_by(id: card_id)

    if card.present?
      if damaged_games_user_id.present? && card.damage > 0
        damaged_user = GamesUser.find_by(id: damaged_games_user_id)
        damage_after_shield = [card.damage - damaged_user.shield, 0].max
        damaged_user.update(hp: [damaged_user.hp - damage_after_shield, 0].max)
        damaged_user.update(shield: [damaged_user.shield - card.damage, 0].max)

        damaged_user.check_end_game
        
      end

      if healed_games_user_id.present? && card.heal > 0
        #ne sum izpolzval .max i .min tuk zashtoto purviq put ne proraboti, az sum time efficent
        healed_user = GamesUser.find_by(id: healed_games_user_id)
        health = healed_user.hp + card.heal
        if health > 10
          health = 10
        elsif health < 0
          health = 0
        end
        healed_user.update(hp: health)
      end

      if shielded_games_user_id.present? && card.shield > 0
        shielded_user = GamesUser.find_by(id: shielded_games_user_id)
        shield = shielded_user.shield + card.shield
        if shield > 10
          shield = 10
        elsif shield < 0
          shield = 0
        end
        shielded_user.update(shield: shield)
      end
    end
  end

  #pole damage_user
  #nova migraciq s novo pole damaged_games_user_id
end
