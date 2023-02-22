class Game < ApplicationRecord
    validates :user_id, presence: true
    has_many :games_users

    belongs_to :user

    #find a way to limit the games a person can create and stop him from creating more than one
    private
        def only_game
            if user.game_id.present?
                errors.add(:user, "Already has a game")
            end
        end    
end
