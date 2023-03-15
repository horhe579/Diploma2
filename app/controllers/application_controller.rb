class ApplicationController < ActionController::Base
    before_action :authenticate_user!, unless: :devise_controller?
    protect_from_forgery with: :null_session

    private

    def latest_game
      @latest_game ||= GamesUser.where(user_id: current_user.id, completed_at: nil).last
    end

    def current_company
      @current_company ||= current_user.company if user_signed_in?
    end
    helper_method :current_company
    helper_method :latest_game
end
