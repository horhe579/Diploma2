class DealtsController < ApplicationController

    def index
    end
    
    def show
    end
    
    def new
        @dealt = Dealt.new(dealts_params)
    end
    
    def create
        @dealt = Dealt.new(dealts_params)
      
          if @dealt.save
            respond_to do |format|
              format.html { redirect_to game_path(latest_game.game_id), notice: "You drew one card." }
              format.turbo_stream do 
                @game = @dealt.games_user.game
                render turbo_stream: turbo_stream.replace(
                  "cards",
                  partial: "games/hand_cards"
                )
              end
            end
          else
            render :new
          end

    end
    
    def edit
    end
    
    def update
      head :no_content
    end

    private
    
    def dealts_params
        params.require(:dealt).permit(:card_id, :games_user_id)
    end
end
