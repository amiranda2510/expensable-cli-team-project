require_relative "presenter"

module Requester
  include Presenter

  def select_main_menu_action
    prompt = "login | create_user | exit"
    options = %w[login create_user exit]
    # p gets_option(prompt, options)
    gets_option(prompt, options)
  end

  def select_menu_expenses_action
    prompt = "create | show ID | update ID | delete ID
    add-to ID | toggle | next | prev | logout"
    options = %w[create show update delete add-to toggle next prev logout]
    # p gets_option(prompt, options)
    gets_option(prompt, options)
  end

  def select_menu_show_category
    prompt = "add | update ID | delete ID
    next | prev | back"
    options = %w[add update ID delete ID next prev back]
    gets_option(prompt, options)
  end

  def user_form
    # NEEDS VALIDATION
    email = gets_string("Email: ")
    password = gets_string("Password: ", length: 6)
    first_name = gets_string("First name: ")
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

  def gets_option(prompt, options, required: true)
    puts prompt
    print "> "
    input = gets.chomp.split.map(&:strip)
    comand = input[0]
    if required || !input.empty?
      until options.include? comand
        puts "Invalid option"
        print "> "
        input = gets.chomp.split.map(&:strip)
        comand = input[0]
      end
    end
    input
  end
end
