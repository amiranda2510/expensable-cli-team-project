require_relative "categories"

module User
  include Categories

  def create_user
    data = user_form # => {}
    @user = UserController.create_user(data)
    print_welcome_messsage(@user[:first_name], @user[:last_name])
    categories
  end
end
