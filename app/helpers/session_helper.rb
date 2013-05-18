module SessionHelper

  # Create a new session id for the given user and save it both on the user object,
  # and in a cookie
  def sign_in(user)
    user.session_id = SecureRandom.hex(16)
    user.save
    cookies[:session_id] = user.session_id
    self.current_user = user
  end

  # delete the stored session cookie for this user
  def sign_out_user(user)
    user.session_id = ''
    user.save
    cookies.delete :session_id
  end

  def current_user=(user)
    @current_user = user
  end

  # if their is a session_id cookie, then attempt to retrieve that user from
  # HyperDex and return them.
  def current_user
    if cookies[:session_id]
      @current_user ||= User.where(session_id: cookies[:session_id])[0]
    else
      nil
    end
  end

  # return true if there is a currently authenticated user
  def signed_in?
    !current_user.nil?
  end

  # redirect to the home page with a flash notice
  # unless there is an authenticated user
  def redirect_unless_signed_in
    unless signed_in?
      flash[:notice] = "You must be logged in to access #{request.fullpath}"
      redirect_to new_session_path
    end
  end  
end
