class GamesController < ApplicationController
    before_action :set_game, only: [:show, :edit, :destroy, :setup_game, :play]

    def new
        @game = Game.new
    end      

    def create 
        @game = Game.new(user_id: current_user.id)


        if latest_game.present?
          redirect_to game_path(latest_game.game_id), alert: "You are already in another game."
          return
        end

        if @game.save
            redirect_to @game, notice: "Game was successfully created."
          else
            render :new, status: :unprocessable_entity
        end
    end
      
    def show
        if @game.games_users.count == 4
            @dealt = Dealt.new(games_user: GamesUser.find_by(user_id: current_user.id, game_id: @game.id))
            render "games/_play" #partial
        else
            render "games/show"
        end
    end

    def destroy
        @game.destroy
        redirect_to games_path, notice: "Game was successfully destroyed."
    end

      
    private
    
        def set_game
            @game = Game.find(params[:id])
        end
    

end
