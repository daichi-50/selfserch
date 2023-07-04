class ApplicationController < ActionController::Base
    before_action :authenticate_user! 

    before_action :configure_permitted_parameters, if: :devise_controller?

    protected

    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
        devise_parameter_sanitizer.permit(:account_update, keys: [:username])
    end

    private 
    def after_sign_in_path_for(resource)
        posts_path # ログイン後に遷移するpathを設定
    end
end
