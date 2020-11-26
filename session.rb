require_relative "session_controller"
require_relative "menu_expenses"

module Session
  include MenuExpenses

  def login
    login_data = login_form

    @user = SessionController.login(login_data)
    print_welcome_messsage(@user[:first_name], @user[:last_name])
    menu_expenses
  end

  def logout
    @user = SessionController.logout(@user[:token])
  end
end
