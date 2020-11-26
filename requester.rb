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
    email = gets_string("Email: ")
    password = gets_string("Password: ", length: 6)
    first_name = gets_string("First name:")
    last_name = gets_string("Last name: ")
    phone = gets_string("Phone: ")
    {
      email: email,
      password: password,
      first_name: first_name,
      last_name: last_name,
      phone: phone
    }
  end

  def login_form
    email = gets_string("Email: ")
    password = gets_string("Password: ")
    { email: email, password: password }
  end

  def gets_string(prompt, required: true, length: 0)
    print prompt
    input = gets.chomp.strip

    if required
      while input.empty? || input.size < length
        puts "Can't be blank" if input.empty?
        puts "Minimium length of #{length}" if input.size < length
        print prompt
        input = gets.chomp.strip
      end
    end
    input
  end
end
