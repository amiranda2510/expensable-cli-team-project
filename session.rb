require_relative "session_controller"

module Session
  # LOGIN

  # LOGOUT
  def logout
    @user = SessionController.logout(@user[:token])
  end
end
