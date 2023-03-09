class TurnsController < ApplicationController
  def index
  end

  def new
    @turn = Turn.new(games_user_id: GamesUser.find_by(id: latest_game.id).id, card_id: params[:card_id])
  end

  def create
    user = GamesUser.find_by(user_id: current_user.id, game_id: latest_game.game_id)
    puts "user: #{user.inspect}"
    if user.present?
      @turn = Turn.new(turns_params.merge(games_user_id: user.id, card_id: params[:turn][:card_id]))
      if @turn.save
        respond_to do |format|
          format.html { redirect_to game_path(latest_game.game_id), notice: "You played a card." }
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
      redirect_to game_path(latest_game.game_id), alert: "Game user not found."
    end
  end

  def update
  end

  def destroy
  end

  private

  def turns_params
    params.require(:turn).permit(:games_user_id, :card_id, :damaged_games_user_id, :healed_games_user_id, :shielded_games_user_id)
  end
end