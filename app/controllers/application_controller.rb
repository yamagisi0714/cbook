class ApplicationController < ActionController::Base
	before_action :configure_permitted_parameters, if: :devise_controller?

	protected
	  def configure_permitted_parameters
	    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :mail])
	    devise_parameter_sanitizer.permit(:sign_in, keys: [:mail])
	  end


	def after_sign_in_path_for(resource)
		user_path(current_user.id)  #　指定したいパスに変更
	end
	# サインアウト後のリダイレクト先をトップページへ
	def after_sign_out_path_for(resource)
		root_path
	end
	# binding.pry
end
