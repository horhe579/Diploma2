class Dealt < ApplicationRecord
  validates :games_user_id, presence: true, uniqueness: { scope: :card_id }
  validates :card_id, presence: true

  belongs_to :games_user
  belongs_to :card
end
