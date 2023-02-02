class CardsController < ApplicationController
    before_action :set_card, only: [:show, :edit, :update, :destroy]

    def index
        @cards = Card.ordered
    end
    
    def show
    end
    
    def new
        @card = Card.new
    end
    
    def create
        @card = Card.new(card_params)
    
        if @card.save
          respond_to do |format|
            format.html { redirect_to cards_path, notice: "Card was successfully created." }
            format.turbo_stream
          end
        else
          render :new, status: :unprocessable_entity
        end
    end
    
    def edit
    end
    
    def update
        if @card.update(card_params)
          redirect_to cards_path, notice: "Card was successfully updated."
        else
          render :edit, status: :unprocessable_entity
        end
    end
    
    def destroy
        @card.destroy

        respond_to do |format|
          format.html { redirect_to cards_path, notice: "Card was successfully destroyed." }
          format.turbo_stream
        end
    end
    
    private
    
    def set_card
        @card = Card.find(params[:id])
    end
    
    def card_params
        params.require(:card).permit(:name)
    end
end
