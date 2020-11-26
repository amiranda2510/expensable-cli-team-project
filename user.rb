module User
  def create_user
    data = user_form # => {}
    user = UserController.create_user(data)
    login user
  end
end
