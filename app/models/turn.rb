class Turn < ApplicationRecord
  validates :games_user_id, presence: true, uniqueness: { scope: :card_id }
  validates :card_id, presence: true

  belongs_to :games_user
  belongs_to :card
  belongs_to :damaged_games_user, optional: true, class_name: "GamesUser"

  #pole damage_user
  #nova migraciq s novo pole damaged_games_user_id
end
