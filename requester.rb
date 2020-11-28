require_relative "presenter"
require "io/console"

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

  def select_transaction_option
    prompt = "add | update ID | delete ID\n"\
             "next | prev | back"
    options = %w[add update ID delete ID next prev back]
    gets_option(prompt, options)
  end

  def user_form
    # NEEDS VALIDATION
    email = gets_string("Email: ")
    password = gets_string("Password: ", length: 8)
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
    email = gets_email("Email: ")
    password = gets_password("Password: ", required: true, length: 6)
    { email: email, password: password }
  end

  def category_form
    name = gets_string("Name: ")
    transaction_type = gets_string("Transaction type: ")
    { name: name, transaction_type: transaction_type }
    # agregar validacion para transaction type
  end

  def transaction_form
    amount = gets_string("Amount: ")
    date = gets_string("Date: ")
    notes = gets_string("Notes: ")
    { amount: amount, date: date, notes: notes }
  end

  def gets_string(prompt, required: true, length: 0)
    print prompt.custom_colorize
    input = gets.chomp.strip

    if required
      while input.empty? || input.size < length
        puts "Can't be blank".red if input.empty?
        puts "Minimium length of #{length}".red if input.size < length
        print prompt.custom_colorize
        input = gets.chomp.strip
      end
    end
    input
  end

  def gets_email(prompt, required: true)
    print prompt.custom_colorize
    input = gets.chomp.strip
    regex_email = /\A[^@\s]+@[^@\s]+\z/
    if required
      while input.empty? || regex_email.match(input).nil?
        puts
        puts "Can't be blank".red if input.empty?
        puts "Incorrect format email /user@mail.com/ ".red if regex_email.match(input).nil?
        print prompt.custom_colorize
        input = gets.chomp.strip
      end
    end
    input
  end

  def gets_password(prompt, required: true, length: 6)
    print prompt.custom_colorize
    input = $stdin.noecho(&:gets).chomp.strip
    if required
      while input.empty? || input.size < length
        puts
        puts "Can't be blank".red if input.empty?
        puts "Minimium length of #{length}".red if input.size < length
        print prompt.custom_colorize
        input = $stdin.noecho(&:gets).chomp.strip
      end
    end
    input
  end

  def gets_option(prompt, options, required: true)
    puts prompt.custom_colorize
    print "> ".custom_colorize
    input = gets.chomp.split.map(&:strip)
    comand = input[0]
    if required || !input.empty?
      until options.include? comand
        puts "Invalid option".red
        print "> ".custom_colorize
        input = gets.chomp.split.map(&:strip)
        comand = input[0]
      end
    end
    input
  end

  def gets_date(prompt, required: true)
    print prompt.custom_colorize
    input = gets.chomp.strip
    return input if input.empty? && !required

    until input.match?(/^2\d\d\d-(0[1-9]|1[0-2])-(0[1-9]|[1-2]\d|3[0-1]$)/)
      puts input.empty? ? "Cannot be empty".red : "Must match 2yyy-mm-dd".red
      print prompt.custom_colorize
      input = gets.chomp.strip
      return input if input.empty? && !required
    end

    input
  end
end
