class ApplicationController < ActionController::Base

  def authenticate_admin
    redirect_to '/users/sign_in' unless user_signed_in?
  end
  
  def after_sign_out_path_for(resource_or_scope)
    '/users/sign_in'
  end

  def current_user_id
    render json: { current_user_id: current_user.id, selected_id:session[:selected_user] }
  end

  def after_sign_in_path_for(resource_or_scope)
    if current_user
      root_path
    else
      redirect_to '/users/sign_in'
    end
  end
end
