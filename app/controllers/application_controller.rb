class ApplicationController < ActionController::Base

	 before_action :configure_permitted_parameters, if: :devise_controller?


  protected

  def configure_permitted_parameters
    added_attrs = [:name, :email, :password, :password_confirmation, :remember_me,
                   :postcode, :prefecture_code, :address_city, :address_street, :latitude, :longitude]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end

  def after_sign_in_path_for(resource)
  	user_path(current_user) #devise機能でログイン後にリダイレクトするページを設定
  end
 def after_sign_out_path_for(resource)
   root_path # ログアウト後にリダイレクトするページを設定
  end

end
