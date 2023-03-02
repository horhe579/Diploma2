class TurnsController < ApplicationController
  def index
  end

  def new
    @turn = Turn.new
  end

  def create
    user = GamesUser.find_by(user_id: current_user.id, game_id: current_user.game_id)
    puts "user: #{user.inspect}"
    if user.present?
      @turn = Turn.new(turns_params.merge(games_user_id: user.id, card_id: params[:turn][:card_id]))
      if @turn.save
        respond_to do |format|
          format.html { redirect_to game_path(current_user.game_id), notice: "You drew one card." }
          format.turbo_stream do
            render turbo_stream: turbo_stream.append(
              "play_card_frame",
              partial: "form",
              locals: { game: @turn }
            )
          end
        end
      else
        render :new
      end
    else
      redirect_to game_path(current_user.game_id), alert: "Game user not found."
    end
  end

  def update
  end

  def destroy
  end

  private

  def turns_params
    params.require(:turn).permit(:games_user_id, :card_id)
  end
end
