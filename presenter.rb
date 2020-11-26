module Presenter
  def print_welcome
    puts "####################################"
    puts "#       Welcome to Expensable      #"
    puts "####################################"
  end

  def gets_option(prompt, options)
    puts prompt
    print "> "
    input = gets.chomp.strip

    until options.include?(input)
      puts "Invalid option"
      print "> "
      input = gets.chomp.strip
    end
    input
  end

  def print_welcome_messsage(name, lastname)
    puts "Welcome to Expensable #{name} #{lastname}"
  end
end
