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
                render turbo_stream: turbo_stream.append(
                  "draw_card_frame",
                  partial: "form",
                  locals: { game: @dealt }
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
    end

    private
    
    def dealts_params
        params.require(:dealt).permit(:card_id, :games_user_id)
    end
end
