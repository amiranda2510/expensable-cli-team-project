require_relative "expenses_menu"

module User
  include ExpensesMenu

  def create_user
    data = user_form # => {}
    @user = UserController.create_user(data)
    print_welcome_messsage(@user[:first_name], @user[:last_name])
    expenses_menu
  end
end
