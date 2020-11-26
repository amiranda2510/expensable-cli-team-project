module User
  def create_user
    data = user_form # => {}
    @user = UserController.create_user(data)
    # probably show the table after this
  end
end
