require_relative "session_controller"

module Session
  def login
    login_data = login_form

    @user = SessionController.login(login_data)
  end
  # logout method
end
