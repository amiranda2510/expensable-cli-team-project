require_relative "session_controller"

module Session
  def login
    login_data = login_form

    @user = SessionController.login(login_data)
    # presentar tablas
  end

  def logout
    @user = SessionController.logout(@user[:token])
  end
end
