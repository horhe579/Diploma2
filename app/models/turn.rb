class Turn < ApplicationRecord
  validates :games_user_id, presence: true, uniqueness: { scope: :card_id }
  validates :card_id, presence: true

  belongs_to :games_user
  belongs_to :card
  belongs_to :damaged_games_user, optional: true, class_name: "GamesUser"
  belongs_to :healed_games_user, optional: true, class_name: "GamesUser"
  belongs_to :shielded_games_user, optional: true, class_name: "GamesUser"


  after_save :apply_card_stats

  def apply_card_stats
    card = Card.find_by(id: card_id)

    if card.present?
      if damaged_games_user_id.present? && card.damage > 0
        damaged_user = GamesUser.find_by(id: damaged_games_user_id)
        damage_after_shield = [card.damage - damaged_user.shield, 0].max
        damaged_user.update(hp: [damaged_user.hp - damage_after_shield, 0].max)
        damaged_user.update(shield: [damaged_user.shield - card.damage, 0].max)
        
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
