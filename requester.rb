require_relative "presenter"

module Requester
  include Presenter

  def select_main_menu_action
    prompt = "login | create_user | exit"
    options = %w[login create_user exit]
    gets_option(prompt, options)
  end

  def gets_option(prompt, options)
    puts prompt
    print ">"
    input = gets.chomp.strip

    until options.include?(input)
      puts "Invalid option"
      print ">"
      input = gets.chomp.strip
    end
    input
  end
end
