module SessionsHelper
 def sign_in(user)
    cookies[:remember_token] = {value: user.remember_token, expires: 15.minutes.from_now}
    current_user = user
  end

def refresh_session()
  cookies[:remember_token] = {value: current_user.remember_token, expires: 15.minutes.from_now}
end


  def signed_in?
    !current_user.nil?
  end
  
   def current_user=(user)
    @current_user = user
  end
  
  def current_user?(user)
    user == current_user
  end
  
   def signed_in_user
    if signed_in?
      refresh_session
    else
      store_location
    
    redirect_to signin_path, notice: "Please sign in." 
    end
  end
  
  def current_user
    @current_user ||= User.find_by_remember_token(cookies[:remember_token])
  end
  
  def sign_out
    current_user = nil
    cookies.delete(:remember_token)
  end
  
  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

  def store_location
    session[:return_to] = request.fullpath
  end
  
  
end
