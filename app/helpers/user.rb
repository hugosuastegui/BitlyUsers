helpers do
  # Esto deberá de regresar al usuario con una sesión actual si es que existe 
  def current_user
    if session[:id]
      @current_user ||= User.find_by_id(session[:id])
    end
  end

  def logged_in?
    !current_user.nil?
  end
  
end