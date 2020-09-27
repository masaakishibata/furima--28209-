class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :exception
  before_action :move_to_index, except: [:index, :show]

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email, :password, :nickname, :birthday])
  end

  def move_to_index
    unless user_signed_in?
      redirect_to action: :index
    end
  end
end
