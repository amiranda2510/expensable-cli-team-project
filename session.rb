require_relative "session_controller"
require_relative "categories"

module Session
  include Categories

  def login
    login_data = login_form

    @user = SessionController.login(login_data)
    print_login_message(@user[:first_name], @user[:last_name])
    categories
  end

  def logout
    @user = SessionController.logout(@user[:token])
  end
end
