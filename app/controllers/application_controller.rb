# Главный контроллер
class ApplicationController < ActionController::Base
  # Фильтр добавления параметров в devise перед запуском экшенов
  before_action :configure_devise_permitted_parameters, if: :devise_controller?
  # Добавление типов для flash-алертов
  add_flash_types :success, :danger
  
  # Проверка пользователя на наличие прав администратора при переходе в админку
  def authenticate_admin_user!
    raise SecurityError unless current_user.try(:admin?)
  end
  
  # В случае если пользователь не админ - редирект на главную
  rescue_from SecurityError do |exception|
    redirect_to root_url
  end

  protected

  # Дополнительные параметры для экшенов девайс контроллера
  def configure_devise_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end
end
