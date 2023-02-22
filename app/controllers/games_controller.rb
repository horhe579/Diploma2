class GamesController < ApplicationController
    before_action :set_game, only: [:show, :edit, :destroy]


    def new
        @game = Game.new
    end      

    def create 
        @game = Game.new(user_id: current_user.id)

        @game.last_selected_deck = params[:last_selected_deck]

        case @game.last_selected_deck
            when "Rogue"
                @game.rogue = false
            when "Wizard"
                @game.wizard = false
            when "Paladin"
                @game.paladin = false
            when "Barbarian"
                @game.barbarian = false
        end

        if @game.save
            redirect_to @game, notice: "Game was successfully created."
          else
            render :new, status: :unprocessable_entity
        end
    end
      
    def show
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
