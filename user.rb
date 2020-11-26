require_relative "menu_expenses"

module User
  include MenuExpenses

  def create_user
    data = user_form # => {}
    @user = UserController.create_user(data)
    print_welcome_messsage(@user[:first_name], @user[:last_name])
    menu_expenses
  end
end
