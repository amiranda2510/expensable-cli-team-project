# Start here. Happy coding!
require_relative "requester"
require_relative "presenter"
require_relative "user_controller"
require_relative "user"
require_relative "session"
require_relative "menu_expenses"
require "pry"

class Expensable
  include Requester
  include Presenter
  include User
  include Session
  include MenuExpenses

  def initialize
    # initialize
  end

  def start
    # start
    print_welcome
    action = select_main_menu_action
    until action == "exit"
      case action
      when "login" then login
      when "create_user" then create_user
      end
      print_welcome
      action = select_main_menu_action
    end
  end
end

expensable = Expensable.new
expensable.start
