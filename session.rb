require_relative "session_controller"
require_relative "expenses_menu"

module Session
  include ExpensesMenu

  def login
    login_data = login_form

    @user = SessionController.login(login_data)
    print_welcome_messsage(@user[:first_name], @user[:last_name])
    expenses_menu
  end

  def logout
    @user = SessionController.logout(@user[:token])
  end
end
