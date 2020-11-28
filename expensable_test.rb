require "minitest/autorun"
require_relative "categories_controller"
require_relative "session_controller"

class ExpensableTest < Minitest::Test
  def test_token_categories_empty
    token = ""
    assert_raises Net::HTTPError do
      CategoriesController.index(token)
    end
  end

  def test_create_category
    login_data = { email: "test10@mail.com", password: "123456" }
    user = SessionController.login(login_data)
    create_data = { name: rand(100_000).to_s, transaction_type: "income" }
    response = CategoriesController.create(user[:token], create_data)
    assert_equal response[:name], create_data[:name]
    assert_equal response[:transaction_type], create_data[:transaction_type]
  end
end
