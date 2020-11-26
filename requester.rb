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

  def user_form
    # NEEDS VALIDATION
    print "Email: "
    email = gets.chomp
    print "Password: "
    password = gets.chomp
    print "First name: "
    first_name = gets.chomp
    print "Last name: "
    last_name = gets.chomp
    print "Phone: "
    phone = gets.chomp
    {
      email: email,
      password: password,
      first_name: first_name,
      last_name: last_name,
      phone: phone
    }
  end
end
