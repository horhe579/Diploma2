class Game < ApplicationRecord
    validates :user_id, presence: true
    has_many :games_users
    has_many :users, through: :games_users

    belongs_to :user

    def player_sort(current_user_id)
        sorted_games_users = games_users.order(created_at: :asc).where.not(current_user_id)
        sorted_games_users.pluck(:user_id)
    end

    #find a way to limit the games a person can create and stop him from creating more than one
    private
        def only_game
            if user.game_id.present?
                errors.add(:user, "Already has a game")
            end
        end    
end
