class GamesController < ApplicationController
    before_action :set_game, only: [:show, :edit, :destroy, :setup_game, :play]

    def new
        @game = Game.new
    end      

    def create 
        @game = Game.new(user_id: current_user.id)

        if @game.save
            redirect_to @game, notice: "Game was successfully created."
          else
            render :new, status: :unprocessable_entity
        end
    end
      
    def show
        if @game.games_users.count == 4
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
