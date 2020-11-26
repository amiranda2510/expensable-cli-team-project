# Start here. Happy coding!
require_relative "requester"
require_relative "presenter"
require_relative "session"

class Expensable
  include Requester
  include Presenter
  include Session

  def initialize
    # initialize
    @user = nil
    @categories = nil
    @incomes = false
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
