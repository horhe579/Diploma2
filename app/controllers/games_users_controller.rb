class GamesUsersController < ApplicationController
  def index
  end

  def show
  end

  def new
    @games_user = GamesUser.new(game_id: params[:game_id], user_id: current_user.id)
    #@games_user = GamesUser.new
  end

  def create
    @games_user = GamesUser.new(games_user_params.merge(user_id: current_user.id))


    if @games_user.save
      respond_to do |format|
        format.html { redirect_to game_path(@games_user.game), notice: "Successfully joined game." }
        format.turbo_stream{ flash.now[:notice] = "Successfully joined game." }
      end
    else
      render :new
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def games_user_params
    params.require(:games_user).permit(:company_id, :game_id)
  end
end
